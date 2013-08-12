# encoding: UTF-8

module ApplicationHelper
  
  # UNIVERSE
  def cancel_link
    return link_to t("labels.actions.cancel"), request.env["HTTP_REFERER"],
      :class => 'cancel',
      :confirm => t("labels.cancel_confirm")
  end
  
  
  # ICONS
  def link_to_function(icon, options = {})
    return link_to(icon, options, :class => "no_hover")
  end
  
  def icon(image_path, alt_text)
    return image_tag(image_path, :alt => alt_text, :title => alt_text)
  end
  
  def icon_show
    return icon("icons/information/Information_16x16.png", t("labels.actions.show"))
  end

  def icon_edit
    return icon("icons/edit/Edit_16x16.png", t("labels.actions.edit"))
  end

  def icon_destroy
    return icon("icons/delete/Delete_16x16.png", t("labels.actions.destroy"))
  end
  
  def icon_new
    return icon("icons/add/Add_16x16.png", t("labels.actions.new"))
  end
  
  def icon_logout
    return icon("icons/log_out/logout_16x16.png", t("labels.actions.logout"))
  end
  
  # LINKS
  def link_to_show(options = {})
    return link_to_function(icon_show, options)
  end

  def link_to_edit(options = {})
    return link_to_function(icon_edit, options)
  end

  def link_to_destroy(object, options = {})
    options.merge!(:class => "no_hover")
    return link_to(icon_destroy, object, options)
  end
  
  def link_to_new(object, options = {})
    options.merge!(:class => "no_hover")
    return link_to(icon_new, object, options)
  end
  
  def link_to_logout(object, options = {})
    options.merge!(:class => "no_hover")
    return link_to(icon_logout, object, options)
  end
  
  
end
