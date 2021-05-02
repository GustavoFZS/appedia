# frozen_string_literal: true

class ThingRequestModel < RequestModel
  field :document, type: String
  field :date, type: Date

  validator_class 'Generic2'
end
