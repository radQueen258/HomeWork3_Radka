module Types
  module Inputs
    class CreateAssignmentInput < Types::BaseInputObject
      argument :project_id, Integer, required: false
      argument :assignment_name, String, required: true
      argument :description, String, required: false
  end
end
end
