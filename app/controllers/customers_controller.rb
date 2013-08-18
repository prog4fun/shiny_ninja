# encoding: UTF-8

class CustomersController < ApplicationController
  
  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  load_and_authorize_resource
  
  def index
    params[:search] ||= {}
    @customers = Customer.search(params[:search], current_user).page(params[:page])
    
    @active_menu = "customer"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end

  def show
    @customer = Customer.find(params[:id])
    
    if current_user.customers.include?(@customer)
      @active_menu = "customer"
      add_breadcrumb t("labels.actions.show"), customer_path(@customer)

      respond_to do |format|
        format.html
      end
      
    else
      not_own_object_redirection
    end
  end

  def new
    @customer = Customer.new
    
    @active_menu = "customer"
    add_breadcrumb t("labels.actions.new"), new_customer_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    
    if current_user.customers.include?(@customer)
      @active_menu = "customer"
      add_breadcrumb t("labels.actions.edit"), edit_customer_path(@customer.id)
    
    else
      not_own_object_redirection
    end
  end

  def create
    @customer = Customer.new(params[:customer])
    
    @active_menu = "customer"

    respond_to do |format|
      params[:customer][:country] = "de"
      if @customer.save
        format.html { redirect_to @customer, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @customer = Customer.find(params[:id])
    
    @active_menu = "customer"

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: t("confirmations.messages.saved") }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    
    @active_menu = "customer"
    
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
    end
  end
  
  #######################################################################
  
  private
  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), customers_path, :title => t("labels.breadcrumbs.index_title")
  end
  
#  def redirect_if_not_own_object
#    raise ActiveRecord::RecordNotFound
#  end
end