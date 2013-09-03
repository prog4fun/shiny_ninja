class ProjectsUserMailer < ActionMailer::Base
  default from: "no-reply-shinyninja@koriath-tech.de"
  
  def existing_user_added_to_project(time_tracker, project_evaluator, project)
    @time_tracker = time_tracker
    @project_evaluator = project_evaluator
    @project = project
    @url  = 'http://example.com/login'
    mail(to: @project_evaluator.email, subject: 'Sie wurden zu einem Projekt hinzugefügt')
  end
  
end
