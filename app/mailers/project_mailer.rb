class ProjectMailer < ApplicationMailer
  def project_created(project, current_user)
    @project = project

    mail(to: current_user.email)
  end

  def project_updated(project, current_user)
    @project = project

    mail(to: current_user.email)
  end

  def project_destroyed(current_user)
    mail(to: current_user.email)
  end
end
