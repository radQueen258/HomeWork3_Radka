module Mutations
  class CreateAssignment < BaseMutation
    argument :input, Types::Inputs::CreateAssignmentInput, required: true

    type Types::Payloads::AssignmentPayload

    def resolve(input:)
      current_user = context[:current_user]
      input_params = input.to_h
      project_id = Project.find_by(input_params.delete(:id))

      result = Assignments::CreateAssignment.call(current_user: current_user,
        project_id: project_id, assignment_params: input_params)

        if result.success?

          # Ensure that result.assignment is not nil before calling formatted_errors
          errors = result.assignment ? formatted_errors(result.assignment) : []
          result.to_h.merge(errors: errors)
        else
          result.to_h.merge(errors: result.errors)
        end
    end
  end
end
