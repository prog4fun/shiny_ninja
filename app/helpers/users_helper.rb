# encoding: UTF-8

module UsersHelper
  
  def get_index_url
    if current_user.is? :administrator
      action = "adm_index"
    elsif current_user.is? :time_tracker
      action = "tt_index"
    elsif current_user.is? :project_evaluator
      action = "pe_index"
    end
    return url_for(:controller => "users", :action => action)
  end
  
end
