# encoding: UTF-8

class UsersController < ApplicationController

  # Filter
  before_filter :authenticate_user!
  # before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  ### Index ###################################################################
  
  def index
    params[:search] ||= {}
    @users = User.search(params[:search]).page(params[:page])
    
    @active_menu = "user"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end
  
  ### Show ####################################################################

  def show
    @user = User.find(params[:id])
    
    own_user = true if current_user.id == @user.id
    if ( current_user.is? :administrator ) || own_user
      @active_menu = "user"
      # add_breadcrumb t("labels.actions.show"), user_path(@user)

      respond_to do |format|
        format.html
      end
    else
      not_own_object_redirection
    end

  end
  
  ### New #####################################################################

  def new
    @user = User.new
    
    @active_menu = "user"
    # add_breadcrumb t("labels.actions.new"), new_user_path

    respond_to do |format|
      format.html
    end
  end
  
  ### Edit ####################################################################

  def edit
    @user = User.find(params[:id])
    
    own_user = true if current_user.id == @user.id
    if ( current_user.is? :administrator ) || own_user
      @active_menu = "user"
      # add_breadcrumb t("labels.actions.edit"), edit_user_path(@user.id)
    else
      not_own_object_redirection
    end
  end
  
  ### Create ##################################################################

  def create
    @user = User.new(user_params)
    
    @active_menu = "user"
        
    respond_to do |format|
      @user.attributes = {:country => "de" }
      if @user.save
        format.html { redirect_to @user, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
              
  end
  
  ### Update ##################################################################

  def update
    @user = User.find(params[:id])
    
    @active_menu = "user"
    
    respond_to do |format|
      params[:user][:country] = "de"
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
      
  end
  
  ### Destroy #################################################################

  def destroy
    @user = User.find(params[:id])
    
    @active_menu = "user"
    
    dependency = @user.customers.count
    dependency += @user.services.count
    if dependency > 0
      flash[:alert] = t("activerecord.models.user") + t("errors.messages.dependency_exists") + " (#{t("activerecord.models.reports")}/#{t("activerecord.models.services")})."
      redirect_to users_url
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
      end
    end
    
  end
  
  ### Other ###################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), users_path, :title => t("labels.breadcrumbs.index_title")
  end
  
  def user_params
	params.require(:user).permit(:city, :comment, :confirmed_at, :country, :email, :firstname, :lastname, :login, :password, :password_confirmation, :phone_number, :remember_me, :roles, :roles_mask, :signature, :street, :street_number, :zipcode)
  end
  
end
