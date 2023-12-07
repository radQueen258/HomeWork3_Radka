module Types
  module Inputs
    class CreateProjectInput < Types::BaseInputObject
      # argument :id, ID, required: true
      argument :name, String, required: true
      argument :description, String, required: false
    end
  end
end
