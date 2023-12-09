module Mutations
  class DeleteProject < BaseMutation
    argument :id, Types::Inputs::DeleteProjectInput, required: true

    type Types::Payloads::ProjectPayload

    def resolve(id:)
      current_user = context[:current_user]
      project = Project.find_by(id: id)

      result = Projects::DeleteProject.call(project: project, current_user: current_user)

        result.to_h.merge(errors: formatted_errors(result.project))
    end
  end
end
