# encoding: UTF-8

class ProjectsUsersController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @project = Project.find(params[:project_id])
    
    customers = current_user.customers
    my_projects = Project.where( :customer_id => customers)
    if my_projects.include?(@project)
    
      @projects_user = ProjectsUser.new :project_token => ProjectsUsersHelper.generate_project_token
      @users = User.where(:roles_mask => 4)  # 4 --> Project Evaluator

      respond_to do |format|
        format.html
      end
    
    else
      not_own_object_redirection
    end
  end
  
  def edit
    @projects_user = ProjectsUser.find(params[:id])
  end

  def confirm_project_evaluator
    # answer of the email with project_token
    @projects_user = ProjectsUser.find_by_project_token(params[:project_token])
    customers = current_user.customers
    my_projects = Project.where( :customer_id => customers)
    
    # time_tracker mustn't be able to evaluate their own projects
    if my_projects.include?(@projects_user.project)
      not_own_object_redirection
    else
    
      # project_evaluator (recipient of the email) is now signed in
      # and we know who the project_evaluator for the project is
      project_evaluator = current_user
      @projects_user.update_attributes(:user_id => project_evaluator.id)
      # if the evaluatur doesn't has the project_evaluator role yet
      project_evaluator.update_attributes(:roles_mask => 6) if project_evaluator.roles_mask == 2 # 2 --> time_tracker; 6 --> time_tracker + project_evaluator
    
      @projects_user.update_attributes(:confirmation_email => nil)
      @projects_user.update_attributes(:project_token => nil)
    
      redirect_to :controller => "reports", :action => "index", :projects_user => @projects_user, notice: t("activerecord.actions.projects_user.confirmed_project_message")
    end
  end

  def create
    @projects_user = ProjectsUser.new(params[:projects_user])
    @project = Project.find(params[:projects_user][:project_id])

    respond_to do |format|
      
      if @projects_user.save
        time_tracker = User.find(current_user.id)
        ProjectsUserMailer.time_tracker_added_project_evaluator(time_tracker, @projects_user, request.domain, request.port).deliver
        
        format.html { redirect_to  :controller => "projects", :action => "edit", :id => params[:projects_user][:project_id], notice: t("activerecord.actions.projects_user.saved_message") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @projects_user = ProjectsUser.find(params[:id])

    respond_to do |format|
      if @projects_user.update_attributes(params[:projects_user])
        format.html { redirect_to @projects_user, notice: 'Projects user was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @projects_user = ProjectsUser.find(params[:id])
    
    if @projects_user.user.present?
      project_evaluator = @projects_user.user
      # if project_evaluaor is time_tracker, too
      if project_evaluator.is? :time_tracker
        # check if he still has other projects to evaluate
        unless project_evaluator.projects.count > 1
          # if he doesn't have any projects left, he just needs to be time_tracker and project_evaluator anymore
          project_evaluator.update_attributes(:roles_mask => 2) # 2 --> time_tracker
        end
      end
    end
    
    @projects_user.destroy
    
    respond_to do |format|
      if params[:project_id].present? # user came from edit page and it's his own project
        format.html { redirect_to :controller => "projects", :action => "edit", :id => params[:project_id], :notice => "Der Zeit-Auswerter wurde erfolgreich von Ihrem Projekt entfernt." }
      else
        format.html { redirect_to :controller => "reports", :action => "index" }
      end
    end
  end
end
