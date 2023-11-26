module Assignments
class DeleteAssignment
  include Interactor
  include Sidekiq::Worker

  delegate :project,:assignment, to: :context

  def call
    assignment = context.assignment

    if assignment.destroy
      context.assignment_deleted = true
      context.message = "Assignment Gracefully Deleted"
    else
      context.fail!(message: "Failed to delete the assignment")
    end
  end

  after do
    AssignmentMailer.assignment_destroyed(project).deliver_later
    Assignments::DeletedAssignmentJob.perform_async(assignment.id)
  end
end
end
