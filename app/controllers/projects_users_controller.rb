# encoding: UTF-8

class ProjectsUsersController < ApplicationController

  def new
    @projects_user = ProjectsUser.new
    @project = Project.find(params[:project_id])
    @users = User.where(:roles_mask => 4)  # 4 --> Project Evaluator

    respond_to do |format|
      format.html
    end
  end

  def edit
    @projects_user = ProjectsUser.find(params[:id])
  end

  def create
    @projects_user = ProjectsUser.new(params[:projects_user])
    @project = Project.find(params[:projects_user][:project_id])
    @users = User.where(:roles_mask => 4)  # 4 --> Project Evaluator

    respond_to do |format|
      if @projects_user.save
        format.html { redirect_to  :controller => "projects", :action => "edit", :id => params[:projects_user][:project_id], notice: t("confirmations.messages.saved") }
      else
        format.html { redirect_to  :controller => "projects", :action => "edit", :id => params[:projects_user][:project_id] }
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
