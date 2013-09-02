# encoding: UTF-8

class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    redirect_to new_session_path(resource_name), notice: "Sie erhalten in wenigen Minuten eine E-Mail mit der Anleitung, wie Sie Ihr Passwort zurücksetzten können."

  end
end