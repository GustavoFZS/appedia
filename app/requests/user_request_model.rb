# frozen_string_literal: true

class UserRequestModel < RequestModel
  field :name, type: String
  field :email, type: String, format: 'a', nullable: true
  field :password, type: Integer, required: false, max: 2
  field :test, type: Hash
  field :thing, model: 'Thing'
end
