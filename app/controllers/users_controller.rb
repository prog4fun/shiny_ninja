# encoding: UTF-8

class UsersController < ApplicationController

  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  def index
    params[:search] ||= {}
    @users = User.search(params[:search], current_user).page(params[:page])
    
    @active_menu = "user"
    @search_bar = true
    @head1 = t("activerecord.models.users")

    respond_to do |format|
      format.html
    end
  end
  
  def adm_index
    params[:search] ||= {}
    @users = User.adm_search(params[:search]).page(params[:page])
    
    @active_menu = "user"
    @search_bar = true
    @head1 = t("activerecord.models.users")

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    
    my_users = User.where("created_by = ? OR id = ?", current_user.id, current_user.id)
    
    if my_users.include?(@user)
      @active_menu = "user"
      @head1 = "#{t("labels.actions.show")} <#{@user.firstname} #{@user.lastname}>"
      add_breadcrumb t("labels.actions.show"), user_path(@user)

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end
  end
  
  def adm_show
    @user = User.find(params[:id])
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.show")} <#{@user.firstname} #{@user.lastname}>"
    add_breadcrumb t("labels.actions.show"), user_path(@user)

    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.new")} #{t("activerecord.models.users")}"
    add_breadcrumb t("labels.actions.new"), new_user_path

    respond_to do |format|
      format.html
    end
  end
  
  def adm_new
    @user = User.new
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.new")} #{t("activerecord.models.users")}"
    add_breadcrumb t("labels.actions.new"), new_user_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    
    my_users = User.where("created_by = ? OR id = ?", current_user.id, current_user.id)
    
    if my_users.include?(@user)
      @active_menu = "user"
      @head1 = "#{t("labels.actions.edit")} #{t("activerecord.models.user")}"
      add_breadcrumb t("labels.actions.edit"), edit_user_path(@user.id)
    else
      not_own_object_redirection
    end
  end
  
  def adm_edit
    @user = User.find(params[:id])
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.edit")} #{t("activerecord.models.user")}"
    add_breadcrumb t("labels.actions.edit"), edit_user_path(@user.id)
  end

  def create
    @user = User.new(params[:user])
    
    @active_menu = "user"

    respond_to do |format|
      @user.attributes = {:country => "de",
        :created_by => current_user.id,
        :roles_mask => 3 }   # 3 --> project_evaluator
      if @user.save
        format.html { redirect_to @user, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    
    @active_menu = "user"

    respond_to do |format|
      params[:user][:country] = "de"
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    
    @active_menu = "user"
    
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end
  
  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), users_path, :title => t("labels.breadcrumbs.index_title")
  end
end
