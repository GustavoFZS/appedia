# frozen_string_literal: true

class ValidatedParams
  attr_accessor :errors_array
  attr_accessor :params

  def error?
    errors.any?
  end

  def errors_str
    errors.join(",\n")
  end

  def errors
    @errors_array ||= []
  end

  def add_param(key, value)
    @params ||= {}
    @params[key.to_sym] = value
  end

  def add_error(error)
    return unless error

    errors << error
  end

  def join(sub_params, model_name)
    @errors_array += sub_params.errors
    add_param(model_name.downcase, sub_params.params)
  end
end
