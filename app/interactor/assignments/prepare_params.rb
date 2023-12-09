module Assignments
  class PrepareParams
    include Interactor

    delegate :assignment_params, :project, to: :context


    def call
    assignment_params = context.assignment_params
    assignment_params[:created_at] = Time.zone.now
    context.validated_params = assignment_params
    end
  end
end
