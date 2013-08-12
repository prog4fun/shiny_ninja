# encoding: UTF-8

class UsersController < ApplicationController

  before_filter :add_breadcrumb_index
  

  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), users_path, :title => t("labels.breadcrumbs.index_title")
  end

  def index
    @users = User.page(params[:page]).per(@@object_quantity_of_one_page)
    
    @active_menu = "user"
    @search_bar = true
    @head1 = t("activerecord.models.users")

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.show")} <#{@user.firstname} #{@user.lastname}>"
    add_breadcrumb t("labels.actions.show"), user_path(@user)

    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new :country => "Deutschland"
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.new")} #{t("activerecord.models.users")}"
    add_breadcrumb t("labels.actions.new"), new_user_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    
    @active_menu = "user"
    @head1 = "#{t("labels.actions.edit")} #{t("activerecord.models.user")}"
    add_breadcrumb t("labels.actions.edit"), edit_user_path(@user.id)
  end

  def create
    @user = User.new(params[:user])
    
    @active_menu = "user"

    respond_to do |format|
      params[:user][:country] = "de"
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
end
