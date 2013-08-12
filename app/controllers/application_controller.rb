# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Index Broadcrumpb
  add_breadcrumb @breadcrump_index_name, :root_path
  
  # fixed_numbers
  @@object_quantity_of_one_page = 18
end
