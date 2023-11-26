module Assignments
 class CreateAssignment
   include Interactor::Organizer
  #  include Sidekiq::Worker

   delegate :assignment, :project, :user, to: :context
   organize Assignments::PrepareParams, Assignments::Save

    after do
     AssignmentMailer.assignment_created(project, assignment, user).deliver_later
     Assignments::CreatedAssignmentJob.perform_async(assignment.id)
   end
 end
end
