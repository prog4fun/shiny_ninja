# encoding: UTF-8

module ApplicationHelper
  
  # UNIVERSE
  def cancel_link
    return link_to t("labels.actions.cancel"), request.env["HTTP_REFERER"],
      :class => 'cancel',
      :confirm => t("labels.actions.cancel_confirm")
  end
  
  # ICONS
  def link_to_function(icon, options = {})
    return link_to(icon, options, :class => "no_hover")
  end
  
  def icon(image_path, alt_text)
    return image_tag(image_path, :alt => alt_text, :title => alt_text)
  end
  
  def icon_show
    # return icon("icons/information/Information_16x16.png", t("labels.actions.show"))
    return "icon-star"
  end

  def icon_edit
    # return icon("icons/edit/Edit_16x16.png", t("labels.actions.edit"))
    return "icon-edit"
  end

  def icon_destroy
    # return icon("icons/delete/Delete_16x16.png", t("labels.actions.destroy"))
    return "icon-remove"
  end
  
  def icon_new
    # return icon("icons/add/Add_16x16.png", t("labels.actions.new"))
    return "icon-plus"
  end
  
  def icon_logout
    return icon("icons/log_out/logout_16x16.png", t("labels.actions.logout"))
  end
  
  # LINKS
  def link_to_show(options = {})
    if can? :show, options
      # return link_to_function(icon_show, options)
      url = url_for(options)
      html_code = "<a class='btn btn-small btn-info' href='#{url}'><i class='#{icon_show}' alt='#{t("labels.actions.show")}' title='#{t("labels.actions.show_explanation")}'></i></a>"
      return raw html_code
    end
  end

  def index_link_to_edit(options = {})
    if can? :update, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-small btn-warning' href='#{url}'><i class='#{icon_edit}' alt='#{t("labels.actions.edit")}' title='#{t("labels.actions.edit_explanation")}'></i></a>"
      return raw html_code
    end
  end
  
   def show_link_to_edit(options = {})
    if can? :update, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-warning' href='#{url}'><i class='#{icon_edit}' alt='#{t("labels.actions.edit")}' title='#{t("labels.actions.edit_explanation")}'></i> #{t("labels.actions.edit")}</a>"
      return raw html_code
    end
  end

  def index_link_to_destroy(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # if can? :destroy, object.class
      # options.merge!(:class => "no_hover")
      # return link_to(icon_destroy, object, options)
      url = url_for(options)
      html_code = "<a class='btn btn-small btn-danger' href='#{url}' class='no_hover' data-confirm='#{t("labels.actions.confirm")}' data-method='delete' rel='nofollow'><i class='#{icon_destroy}' alt='#{t("labels.actions.destroy")}' title='#{t("labels.actions.destroy_explanation")}'></i></a>"
      return raw html_code
      
    end
  end
  
  def show_link_to_destroy(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # if can? :destroy, object.class
      # options.merge!(:class => "no_hover")
      # return link_to(icon_destroy, object, options)
      url = url_for(options)
      html_code = "<a class='btn btn-danger' href='#{url}' class='no_hover' data-confirm='#{t("labels.actions.confirm")}' data-method='delete' rel='nofollow'><i class='#{icon_destroy}' alt='#{t("labels.actions.destroy")}' title='#{t("labels.actions.destroy_explanation")}'></i>#{t("labels.actions.destroy")}</a>"
      return raw html_code
      
    end
  end
  
  def link_to_new(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # return link_to_function(icon_new, options)
      url = url_for(options)
      html_code = "<a class='btn btn-primary' href='#{url}'><i class='#{icon_new}' alt='#{t("labels.actions.new")}' title='#{t("labels.actions.new_explanation")}'></i> #{t("labels.actions.new")}</a>"
      return raw html_code
    end
  end
  
  
  def link_to_logout(object, options = {})
    options.merge!(:class => "no_hover")
    return link_to(icon_logout, object, options)
  end
  
  
  def hash_with_controller_to_model(hash)
    model = hash[:controller].singularize.camelize.constantize
    return model
  end

  
end
