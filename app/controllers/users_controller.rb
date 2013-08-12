# encoding: UTF-8

class UsersController < ApplicationController


  def index
    @users = User.all
    
    @active_menu = "user"
    @search_bar = true
    @head1 = t('activerecord.models.users')

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    
    @active_menu = "user"
    @head1 = "Show < " + @user.firstname + " " + @user.lastname + " >"

    respond_to do |format|
      format.html
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new :country => "Deutschland"
    
    @active_menu = "user"
    @head1 = "New " + t('activerecord.models.user').pluralize

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    
    @active_menu = "user"
    @head1 = "Edit < " + t('activerecord.models.user') + " >"
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
