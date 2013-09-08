# encoding: UTF-8

class ProjectsUsersController < ApplicationController
  # Filter
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @projects_user = ProjectsUser.new :project_token => ProjectsUsersHelper.generate_project_token
    @project = Project.find(params[:project_id])
    @users = User.where(:roles_mask => 4)  # 4 --> Project Evaluator

    respond_to do |format|
      format.html
    end
  end

  def edit
    @projects_user = ProjectsUser.find(params[:id])
  end
  
  def confirm_project_evaluator
    # answer of the email with project_token
    @projects_user = ProjectsUser.find_by_project_token(params[:project_token])
    # project_evaluator (recipient of the email) is now signed in
    
    
    # project_evaluator (recipient of the email) is now signed in
    # and we know who the project_evaluator for the project is
    project_evaluator = current_user
    @projects_user.update_attributes(:user_id => project_evaluator.id)
    # if the evaluatur doesn't has the project_evaluator role yet
    project_evaluator.update_attributes(:roles_mask => 6) if project_evaluator.roles_mask == 2 # 2 --> time_tracker; 6 --> time_tracker + project_evaluator
    
    @projects_user.update_attributes(:confirmation_email => nil)
    @projects_user.update_attributes(:project_token => nil)
    
    redirect_to :controller => "reports", :action => "index", :project_to_evaluate => @projects_user.project, notice: t("confirmations.messages.saved")
    
  end

  def create
    @projects_user = ProjectsUser.new(params[:projects_user])
    @project = Project.find(params[:projects_user][:project_id])

    respond_to do |format|
      
      if @projects_user.save
        time_tracker = User.find(current_user.id)
        ProjectsUserMailer.time_tracker_added_project_evaluator(time_tracker, @projects_user).deliver
        
        format.html { redirect_to  :controller => "projects", :action => "edit", :id => params[:projects_user][:project_id], notice: t("confirmations.messages.saved") }
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
    @projects_user = ProjectsUser.find_by_project_id_and_user_id(params[:project_id], params[:user_id])
    @projects_user.destroy

    respond_to do |format|
      format.html { redirect_to :controller => "projects", :action => "edit", :id => params[:project_id] }
    end
  end
end
