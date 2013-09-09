# encoding: UTF-8

class ProjectsUserMailer < ActionMailer::Base
  default from: "no-reply-shinyninja@koriath-tech.de"
  
  def existing_project_evaluator_added_to_project(time_tracker, projects_user)
    @time_tracker = time_tracker
    @project_evaluator = projects_user.user
    @project = projects_user.project
    mail(to: @project_evaluator.email, subject: 'Sie wurden zu einem Projekt hinzugefügt')
  end
  
  def existing_time_tracker_added_to_project(time_tracker, projects_user)
    # means: if time_tracker is no project_evaluator yet
    @time_tracker = time_tracker
    @project_evaluator = projects_user.user
    @project = projects_user.project
    mail(to: @project_evaluator.email, subject: 'Sie wurden zu einem Projekt hinzugefügt')
  end
  
  
  
  def not_found_project_evaluator_added_to_project(time_tracker, projects_user)
    @time_tracker = time_tracker
    @projects_user = projects_user
    @project = projects_user.project
    mail(to: @projects_user.unknown_email, subject: 'Sie wurden zu einem Projekt hinzugefügt')
  end
  
  def time_tracker_added_project_evaluator(time_tracker, projects_user)
    @time_tracker = time_tracker
    @projects_user = projects_user
    @project = projects_user.project
    mail(to: @projects_user.confirmation_email, subject: 'Sie wurden zu einem Projekt hinzugefügt')
  end

  
end
