# encoding: UTF-8

module ApplicationHelper
  
  # UNIVERSE
  def cancel_link
    url = url_for(request.env["HTTP_REFERER"])
    html_code = "<a class='btn btn-small btn-danger' href='#{url}' data-confirm='#{t("labels.actions.confirm")}'>#{t("labels.actions.cancel")}</a>"
    return raw html_code
  end
  
  def search_active?
    params[:search].present? ? true : false
  end
  
  # ICONS
  def icon_boolean(state)
    if state == true
      return t("labels.state.positive")
    else
      return t("labels.state.negative")
    end
  end
  
  
  def link_to_function(icon, options = {})
    return link_to(icon, options, :class => "no_hover")
  end
  
  def icon(image_path, alt_text)
    return image_tag(image_path, :alt => alt_text, :title => alt_text)
  end
  
  def icon_index
    return "glyphicon glyphicon-th-list"
  end
    
  def icon_show
    # return icon("icons/information/Information_16x16.png", t("labels.actions.show"))
    return "glyphicon glyphicon-eye-open"
  end

  def icon_edit
    # return icon("icons/edit/Edit_16x16.png", t("labels.actions.edit"))
    return "glyphicon glyphicon-edit"
  end

  def icon_destroy
    # return icon("icons/delete/Delete_16x16.png", t("labels.actions.destroy"))
    return "glyphicon glyphicon-remove"
  end
  
  def icon_new
    # return icon("icons/add/Add_16x16.png", t("labels.actions.new"))
    return "icon-plus"
  end
  
  def icon_logout
    return icon("icons/log_out/logout_16x16.png", t("labels.actions.logout"))
  end
  
  # LINKS
  def show_link_to_index(options = {})
    if can? :tt_show, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-small btn-info' href='#{url}'><span class='#{icon_index}' alt='#{t("labels.actions.index")}' title='#{t("labels.actions.index_explanation")}'></span> #{t("labels.actions.index")}</a>"
      return raw html_code
    end
  end
  
  def link_to_show(options = {})
    #if can? :tt_show, options
    # return link_to_function(icon_show, options)
    url = url_for(options)
    html_code = "<a class='btn btn-small btn-info' href='#{url}'><span class='#{icon_show}' alt='#{t("labels.actions.show")}' title='#{t("labels.actions.show_explanation")}'></span></a>"
    
    return raw html_code
    #end
  end

  def index_link_to_edit(options = {})
    if can? :update, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<td style='width:5%'><a class='btn btn-small btn-warning' href='#{url}'><i class='#{icon_edit}' alt='#{t("labels.actions.edit")}' title='#{t("labels.actions.edit_explanation")}'></i></a></td>"
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
      html_code = "<td style='width:5%'><a class='btn btn-small btn-danger no_hover' href='#{url}' data-confirm='#{t("labels.actions.confirm")}' data-method='delete' rel='nofollow'><i class='#{icon_destroy}' alt='#{t("labels.actions.destroy")}' title='#{t("labels.actions.destroy_explanation")}'></i></a></td>"
      return raw html_code
      
    end
  end
  
  def show_link_to_destroy(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # if can? :destroy, object.class
      # options.merge!(:class => "no_hover")
      # return link_to(icon_destroy, object, options)
      url = url_for(options)
      html_code = "<a class='btn btn-danger no_hover' href='#{url}' data-confirm='#{t("labels.actions.confirm")}' data-method='delete' rel='nofollow'><i class='#{icon_destroy}' alt='#{t("labels.actions.destroy")}' title='#{t("labels.actions.destroy_explanation")}'></i> #{t("labels.actions.destroy")}</a>"
      return raw html_code
      
    end
  end
  
   def link_to_destroy_evaluator(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # if can? :destroy, object.class
      # options.merge!(:class => "no_hover")
      # return link_to(icon_destroy, object, options)
      url = url_for(options)
      html_code = "<a class='btn btn-danger btn-xs no_hover' href='#{url}' data-confirm='#{t("labels.actions.confirm")}' data-method='delete' rel='nofollow'><i class='#{icon_destroy}' alt='#{t("labels.actions.destroy")}' title='#{t("labels.actions.destroy_explanation")}'></i></a>"
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
  
  # needs to be merged with method above!!
  def link_to_new_evaluator(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # return link_to_function(icon_new, options)
      url = url_for(options)
      html_code = "<a class='btn btn-primary' href='#{url}'><i class='#{icon_new}' alt='#{t("labels.actions.new")}er #{t("labels.roles.projectevaluator")}' title='#{t("labels.actions.new_explanation")}'></i> #{t("labels.actions.new")}er #{t("labels.roles.projectevaluator")}</a>"
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
