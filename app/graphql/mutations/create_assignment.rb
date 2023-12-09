module Mutations
  class CreateAssignment < BaseMutation
    argument :input, Types::Inputs::CreateAssignmentInput, required: true

    type Types::Payloads::AssignmentPayload

    def resolve(input:)
      current_user = context[:current_user]
      project_id = Project.find(assignment_params[:project_id])
      result = Assignments::CreateAssignment.call(current_user: current_user, project_id: project_id, assignment_params: input.to_h)

      if result.success?
        result
      else
        result.to_h.merge(errors: formatted_errors(result.assignment))
      end
    end
  end
end
