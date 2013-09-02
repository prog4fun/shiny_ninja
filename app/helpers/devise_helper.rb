# encoding: UTF-8

module DeviseHelper
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  def devise_error_messages!
    return "" if resource.errors.empty?
   
    if resource.errors[:email].present?
      return flash[:notice] = "Sie erhalten in wenigen Minuten eine E-Mail mit der Anleitung, wie Sie Ihr Passwort zurücksetzten können. "
    end

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
      :count => resource.errors.count,
      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
<div class="alert alert-danger id="error_explanation">
<h4><strong>#{sentence}</strong></h4>
<ul>#{messages}</ul>
</div>
    HTML

    html.html_safe
  end
end