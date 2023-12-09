module Mutations
  class DeleteProject < BaseMutation
    argument :input, Types::Inputs::DeleteProjectInput, required: true

    type Types::Payloads::ProjectPayload

    def resolve(input:)
      current_user = context[:current_user]
      result = Projects::DeleteProject.call(project: ::Project.find(:id),
        project_params:project_params, current_user: current_user)

        result.to_h.merge(errors: formatted_errors(result.project))
    end
  end
end
