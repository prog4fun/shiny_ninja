# encoding: UTF-8

class ProjectsUserMailer < ActionMailer::Base
  default from: "no-reply@codeline.me"
  
  def time_tracker_added_project_evaluator(time_tracker, projects_user, domain, port)
    @time_tracker = time_tracker
    @projects_user = projects_user
    @project = projects_user.project
    @domain = domain
    @port = port
    mail(to: @projects_user.confirmation_email, subject: 'Sie wurden zu einem Projekt hinzugefügt')
  end

  
end
