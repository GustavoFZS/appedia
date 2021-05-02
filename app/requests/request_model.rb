# frozen_string_literal: true

class RequestModel
  STATIC_VALIDATIONS = %i[required desc example model].freeze

  class_attribute :validator_instance
  class_attribute :required_fields
  class_attribute :optional_fields
  class_attribute :all_fields

  def self.validate_params(params, name = 'Request')
    validated_params = ValidatedParams.new
    unless params.class == Hash
      validated_params.add_error("#{name} deve ser um json")
      return validated_params
    end

    check_errors(params, validated_params)
    params.each do |param|
      if all_fields.keys.include?(param[0])
        validated_params.add_param(param[0], param[1])
      end
    end
    validated_params
  end

  def self.check_errors(params, validated_params)
    missing_params(params, validated_params)

    params.each do |param|
      key = param[0]
      value = param[1]

      fields[key]&.each do |validation|
        validation_type = validation[0]
        validation_option = validation[1]

        if static_validations.exclude?(validation_type)
          validator.send("valid_#{validation_type}?", key, value, validated_params)
        end

        if validation_type == :model
          sub_params = "#{validation_option}RequestModel".constantize.validate_params(params[param[0]], validation_option)
          validated_params.join(sub_params, validation_option)
        end
      end
    end
  end

  def self.missing_params(params, validated_params)
    missing_params = required_fields.keys - params.keys
    if missing_params.present?
      validated_params.add_error("Parâmetros obrigatórios não encontrados: #{missing_params.join(', ')}")
    end
  end

  def self.fields
    self.all_fields ||= required_fields.merge(optional_fields)
  end

  def self.field(name, options)
    self.required_fields ||= {}
    self.optional_fields ||= {}
    if options[:required] || options[:required].nil?
      self.required_fields[name] = options
    else
      self.optional_fields[name] = options
    end
  end

  def self.static_validations
    STATIC_VALIDATIONS + validator.static_validations
  end

  def self.validator
    self.validator_instance ||= GenericValidator.new(fields)
  end

  def self.validator_class(validator_name)
    self.validator_instance = "#{validator_name}Validator".constantize.new(fields)
  end
end
