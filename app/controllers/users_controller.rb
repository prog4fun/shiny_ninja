# encoding: UTF-8

class UsersController < ApplicationController

  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  ### Index ###################################################################
  
  def tt_index
    params[:search] ||= {}
    @users = User.search(params[:search], current_user).page(params[:page])
    
    @active_menu = "user"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end
  
  def adm_index
    params[:search] ||= {}
    @users = User.adm_search(params[:search]).page(params[:page])
    
    @active_menu = "user"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end
  
  ### Show ####################################################################

  def tt_show
    @user = User.find(params[:id])
    
    my_users = User.where("created_by = ? OR id = ?", current_user.id, current_user.id)
    
    if my_users.include?(@user)
      @active_menu = "user"
      add_breadcrumb t("labels.actions.show"), user_path(@user)

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end
  end
  
  def pe_show
    @user = current_user
  
    @active_menu = "user"
    add_breadcrumb(t("labels.actions.show"), :controller => "users", :action => "pe_show")
      
  end
  
  def adm_show
    @user = User.find(params[:id])
    @creator = User.find(@user.created_by)
    
    @active_menu = "user"
    add_breadcrumb t("labels.actions.show"), user_path(@user)

    respond_to do |format|
      format.html
    end
  end
  
  ### New #####################################################################

  def tt_new
    # new for an time_tracker to create an project_evaluator
    @user = User.new
    
    @active_menu = "user"
    add_breadcrumb t("labels.actions.new"), new_user_path

    respond_to do |format|
      format.html
    end
  end
  
  def adm_new
    @user = User.new
    
    @active_menu = "user"
    add_breadcrumb t("labels.actions.new"), new_user_path

    respond_to do |format|
      format.html
    end
  end
  
  ### Edit ####################################################################

  def tt_edit
    @user = User.find(params[:id])
    
    my_users = User.where("created_by = ? OR id = ?", current_user.id, current_user.id)
    
    if my_users.include?(@user)
      @active_menu = "user"
      add_breadcrumb t("labels.actions.edit"), edit_user_path(@user.id)
    else
      not_own_object_redirection
    end
  end

  def pe_edit
    @user = current_user
  
    @active_menu = "user"
    add_breadcrumb(t("labels.actions.edit"), :controller => "users", :action => "pe_edit")
  end
  
  def adm_edit
    @user = User.find(params[:id])
    
    @active_menu = "user"
    add_breadcrumb t("labels.actions.edit"), edit_user_path(@user.id)
  end
  
  ### Create ##################################################################

  def create
    @user = User.new(params[:user])
    
    @active_menu = "user"
    
    if current_user.is? :administrator
      respond_to do |format|
        @user.attributes = {:country => "de",
          :created_by => current_user.id }
        if @user.save
          format.html { redirect_to action: "adm_show", id: @user.id, notice: t("confirmations.messages.saved") }
        else
          format.html { render action: "adm_new" }
        end
      end
      
    else  # no administrator
      respond_to do |format|
        ###
        @user.attributes = { :login => "p-" << params[:user][:login],
          ###
          :country => "de",
          :created_by => current_user.id,
          :roles_mask => 4 }   # 4 --> project_evaluator
        if @user.save
          format.html { redirect_to @user, id: @user.id, notice: t("confirmations.messages.saved") }
        else
          format.html { render action: "new" }
        end
      end
    end
    
  end
  
  ### Update ##################################################################

  def update
    @user = User.find(params[:id])
    
    @active_menu = "user"
    
    if current_user.is? :administrator

      respond_to do |format|
        params[:user][:country] = "de"
        if @user.update_attributes(params[:user])
          format.html { redirect_to action: "adm_show", id: @user.id, notice: t("confirmations.messages.saved") }
        else
          format.html { render action: "adm_edit" }
        end
      end
    
    else  # no administrator
      respond_to do |format|
        params[:user][:country] = "de"
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, id: @user.id, notice: t("confirmations.messages.saved") }
        else
          format.html { render action: "tt_edit" }
        end
      end
    end
    
  end
  
  ### Destroy #################################################################

  def destroy
    @user = User.find(params[:id])
    
    @active_menu = "user"
    
    if current_user.is? :administrator
      dependency = @user.customers.count
      dependency += @user.services.count
      if dependency > 0
        flash[:alert] = t("activerecord.models.user") + t("errors.messages.dependency_exists") + " (#{t("activerecord.models.reports")}/#{t("activerecord.models.services")})."
        redirect_to action: "adm_index"
      else
        @user.destroy
        respond_to do |format|
          format.html { redirect_to action: "adm_index" }
        end
      end
    
    else  # no administrator
      
      dependency = @user.customers.count
      dependency += @user.services.count
      if dependency > 0
        flash[:alert] = t("activerecord.models.user") + t("errors.messages.dependency_exists") + " (#{t("activerecord.models.reports")}/#{t("activerecord.models.services")})."
        redirect_to action: "tt_index"
      else
        my_users = User.where("created_by = ?", current_user.id)
        if my_users.include?(@user)
          @user.destroy
          respond_to do |format|
            format.html { redirect_to action: "tt_index" }
          end
        else
          not_own_object_redirection
        end
      end
    end
  end
  
  ### Other ###################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), users_path, :title => t("labels.breadcrumbs.index_title")
  end
end
