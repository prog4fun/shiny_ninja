# encoding: UTF-8

class CustomersController < ApplicationController

  # Filter
  before_filter :authenticate_user!
  before_filter :add_breadcrumb_index
  
  def index
    @customers = Customer.page(params[:page]).per(@@object_quantity_of_one_page)
    
    @active_menu = "customer"
    @search_bar = true
    @head1 = t("activerecord.models.customers")

    respond_to do |format|
      format.html
    end
  end

  def show
    @customer = Customer.find(params[:id])
    
    @active_menu = "customer"
    @head1 = "#{t("labels.actions.show")} <#{@customer.firstname} #{@customer.lastname}>"
    add_breadcrumb t("labels.actions.show"), customer_path(@customer)

    respond_to do |format|
      format.html
    end
  end

  def new
    @customer = Customer.new
    
    @active_menu = "customer"
    @head1 = "#{t("labels.actions.new")} #{t("activerecord.models.customers")}"
    add_breadcrumb t("labels.actions.new"), new_customer_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    
    @active_menu = "customer"
    @head1 = "#{t("labels.actions.edit")} #{t("activerecord.models.customer")}"
    add_breadcrumb t("labels.actions.edit"), edit_customer_path(@customer.id)
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
end