# encoding: UTF-8

module ApplicationHelper

  # UNIVERSE
  def cancel_link
    url = url_for(request.env["HTTP_REFERER"])
    html_code = "<a class='btn btn-small btn-danger' href='#{url}' data-confirm='#{t("labels.actions.confirm")}'>#{t("labels.actions.cancel")}</a>"
    return raw html_code
  end

  # Checks search parameters.
  # Takes exceptions as Hash (key value) which will be ignored (can be present but won't care).
  # returns true if search parameters (minus exceptions) are present. False if not.
  def search_active?(key = nil, value = nil)
    #def search_active?(key, value)
    # raise
    if (key.nil? || value.nil?) || params[:search][key] == value
      if params[:search][:archived] == 'false'
        if params[:search].except(:archived, key).present?
          true
        else
          false
        end
      else
        # "params[:search][key] == value ? false : true" will be enough
        # if every model has a archive function
        if params[:search].except(:archived).present?
          true
        else
          false
        end
      end

    else
      true
    end

  end


# Returns a String of the translated month name.
# Takes a date (not formatted).
# Reduces 1 month of the date and builds the month name of it.
# Locales caused a problem to display a incorrect month name. This methods works as a workaround.
  def get_translated_month_name(date)
    I18n.localize(date - 1.month, :format => '%B')
  end

# ICONS
  def icon_boolean(state)
    if state == true
      return raw "<i class='#{icon_yes}' alt='#{t("labels.state.positive")}' title='#{t("labels.state.positive")}'></i>"
    else
      return raw "<i class='#{icon_no}' alt='#{t("labels.state.negative")}' title='#{t("labels.state.negative")}'></i>"
    end
  end

# archive dropdown (e.g. in filters)
  def options_for_archive(element_translation)
    options_for_select([[t("labels.state.not_archived", elements: element_translation), 'false'],
                        [t("labels.state.archived", elements: element_translation), 'true'],
                        [t("labels.universe.all", elements: element_translation), nil]],
                       selected: params[:search][:archived])
  end

  def link_to_function(icon, options = {})
    return link_to(icon, options, :class => "no_hover")
  end

  def icon(image_path, alt_text)
    return image_tag(image_path, :alt => alt_text, :title => alt_text)
  end

  def icon_yes
    return "glyphicon glyphicon-check"
  end

  def icon_no
    return "glyphicon glyphicon-unchecked"
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

  def icon_archive
    return 'glyphicon glyphicon-floppy-save'
  end

  def icon_restore
    return 'glyphicon glyphicon-floppy-open'
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

  def link_to_edit(options = {})
    if can? :update, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-small btn-warning' href='#{url}'><i class='#{icon_edit}' alt='#{t("labels.actions.edit")}' title='#{t("labels.actions.edit_explanation")}'></i></a>"
      return raw html_code
    end
  end

  def link_to_destroy(options = {})
    if can? :create, hash_with_controller_to_model(options)
      # if can? :destroy, object.class
      # options.merge!(:class => "no_hover")
      # return link_to(icon_destroy, object, options)
      url = url_for(options)
      html_code = "<a class='btn btn-small btn-danger no_hover' href='#{url}' data-confirm='#{t("labels.actions.confirm")}' data-method='delete' rel='nofollow'><i class='#{icon_destroy}' alt='#{t("labels.actions.destroy")}' title='#{t("labels.actions.destroy_explanation")}'></i></a>"
      return raw html_code
    end
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

  def show_link_to_archive(options = {})
    if can? :archive, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-success' href='#{url}'><i class='#{icon_archive}' alt='#{t("labels.actions.archive")}' title='#{t("labels.actions.archive_explanation")}'></i> #{t("labels.actions.archive")}</a>"
      return raw html_code
    end
  end

  def show_link_to_archive_confirm(confirm_text, options = {})
    if can? :archive, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-success' href='#{url}' data-confirm='#{confirm_text}'><i class='#{icon_archive}' alt='#{t("labels.actions.archive")}' title='#{t("labels.actions.archive_explanation")}'></i> #{t("labels.actions.archive")}</a>"
      return raw html_code
    end
  end

  def show_link_to_restore(options = {})
    if can? :archive, hash_with_controller_to_model(options)
      url = url_for(options)
      html_code = "<a class='btn btn-success' href='#{url}'><i class='#{icon_restore}' alt='#{t("labels.actions.restore")}' title='#{t("labels.actions.restore_explanation")}'></i> #{t("labels.actions.restore")}</a>"
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
