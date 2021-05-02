# frozen_string_literal: true

class GenericValidator
  STATIC_VALIDATIONS = %i[nullable].freeze

  attr_accessor :fields

  def initialize(fields)
    @fields = fields
  end

  def valid_type?(key, value, validated_params)
    value_class = value.class
    return if fields[key][:nullable] && value.nil?

    if value_class != fields[key][:type] && !fields[key][:nullable]
      validated_params.add_error(add_type_error(key, fields[key][:type]))
    end
  end

  def valid_format?(key, value, validated_params)
    return if fields[key][:nullable] && value.nil?

    validated_params.add_error(add_type_error(key, 'String')) if value.class != String
    unless value =~ /#{fields[key][:format]}/
      validated_params.add_error("#{key} deve ter o formato: /#{fields[key][:format]}/")
    end
  end

  def valid_max?(key, value, validated_params)
    return if fields[key][:nullable] && value.nil?

    if value.class != Integer && value.class != Float
      validated_params.add_error(add_type_error(key, 'number'))
    end
    if value > fields[key][:max]
      validated_params.add_error("#{key} não pode ser maior que: #{fields[key][:max]}")
    end
  end

  def valid_min?(key, value, validated_params)
    return if fields[key][:nullable] && value.nil?

    if value.class != Integer && value.class != Float
      validated_params.add_error(add_type_error(value, 'number'))
    end
    if value < fields[key][:min]
      validated_params.add_error("#{key} não pode ser maior que: #{fields[key][:min]}")
    end
  end

  def add_type_error(key, type)
    "#{key} deve ser do tipo #{type}"
  end

  def static_validations
    STATIC_VALIDATIONS
  end
end
