module Assignments
class UpdateAssignment
  include Interactor
  include Sidekiq::Worker

  delegate :assignment, :project, to: :context

  def call
    assignment = context.assignment
    updated_attributes = context.updated_attributes

    if assignment.update(updated_attributes)
      context.assignment = assignment
      context.message = "Assignment Gracefully Updated"
    else
      context.fail!(message: "Failed to update the assignment")
    end
  end

  after do
    AssignmentMailer.assignment_updated(assignment, project).deliver_later
    Assignments::UpdatedAssignmentJob.perform_async(assignment.id)
  end
end
end
