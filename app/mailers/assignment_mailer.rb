class AssignmentMailer < ApplicationMailer
  def assignment_created(project, assignment, user)
    @project = project
    @assignment = assignment
    mail(to: user.email)
  end

  def assignment_updated(project, assignment)
    @project = project
    @assignment = assignment
    mail(to: project.current_user.email)
  end

  def assignment_destroyed(project)
    @project = project
    mail(to: project.current_user.email)
  end
end
