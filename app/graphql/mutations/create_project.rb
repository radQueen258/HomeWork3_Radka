module Mutations
  class CreateProject < BaseMutation

    def resolve(input)
      result = Projects::Create.call(
        project_params: input,
        user: current_user)

      result.success? ? result.project : nil
    end
  end
end
