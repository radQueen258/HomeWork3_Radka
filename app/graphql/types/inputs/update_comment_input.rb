module Types
  module Inputs
    class UpdateCommentInput < Types::BaseInputObject
      # argument :id, ID, required: true
      # argument :assignment_id, Integer, required: true
      # argument :user_id, Integer, required: true
      argument :content, String, required: true
    end
  end
end
