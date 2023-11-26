module Projects
class PrepareParams1
  include Interactor

  def call
    project_params = context.project_params
    context.validated_params = project_params
  end
end
end
