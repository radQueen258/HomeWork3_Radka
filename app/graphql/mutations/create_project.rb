module Mutations
  class CreateProject < BaseMutation

    argument :input, Types::Inputs::CreateProjectInput, required: true


    type Types::Payloads::ProjectPayload

    def resolve(input:)
      current_user = context[:current_user]
      result = Projects::CreateProject.call(project_params: input.to_h, current_user: current_user)

      if result.success?
        result
      else
        result.to_h.merge(errors: formatted_errors(result.project))
      end

    end
  end
end
