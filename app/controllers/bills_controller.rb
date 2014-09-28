# encoding: UTF-8

class BillsController < ApplicationController
  include BillsHelper

  # Filter
  before_filter :authenticate_user!

  # before_filter :add_breadcrumb_index
  load_and_authorize_resource


  def index
    @customers = current_user.customers
    params[:search] ||= {}
    @bills = Bill.search(params[:search], current_user).page(params[:page])

    @active_menu = "bill"
    @search_bar = true

    respond_to do |format|
      format.html
    end
  end

  def show
    @bill = Bill.find(params[:id])

    customers = current_user.customers
    my_bills = Bill.where(:customer_id => customers)

    if my_bills.include?(@bill)
      @active_menu = "bill"
    else
      not_own_object_redirection
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bill }
    end
  end

  def new
    @bill = Bill.new :number => Bill.generate_bill_number,
                     :date => Date.today,
                     :year => get_current_year
    @customers = current_user.customers
    redirect_to controller: :customers, action: :new, alert: t("activerecord.attributes.customer.dependency") and return if @customers.empty?

    @active_menu = "bill"
    add_breadcrumb t("labels.actions.new"), new_bill_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    @bill = Bill.find(params[:id])

    @customers = current_user.customers
    my_bills = Bill.where(:customer_id => @customers)

    if my_bills.include?(@bill)
      @bill.year = @bill.year.to_s[0..-1]
      @active_menu = "bill"
      add_breadcrumb t("labels.actions.edit"), edit_bill_path(@bill.id)
    else
      not_own_object_redirection
    end
  end

  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        @bill.update_attribute(:creator_id, current_user.id)
        format.html { redirect_to @bill, notice: t("confirmations.messages.saved") }
      else
        @customers = current_user.customers
        format.html { render action: "new" }
      end
    end
  end

  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(bill_params)
        format.html { redirect_to @bill, notice: t("confirmations.messages.saved") }
      else
        @customers = current_user.customers
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @bill = Bill.find(params[:id])
    @active_menu = "project"
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url }
    end
  end

  #######################################################################

  private

  def add_breadcrumb_index
    add_breadcrumb t("labels.breadcrumbs.index"), customers_path, :title => t("labels.breadcrumbs.index_title")
  end

  def bill_params
    params.require(:bill).permit(:amount, :comment, :creator_id, :customer_id, :date, :month, :number, :paid, :year)
  end

end
