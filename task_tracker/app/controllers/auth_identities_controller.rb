class AuthIdentitiesController < ApplicationController
  def create
    auth_identity = AuthIdentity.find_or_create_with_omniauth(auth_hash)
    if auth_identity.persisted?
      sign_in_and_redirect(auth_identity.user)
    else
      redirect_to root_path, alert: "Failed to sign in with #{auth_hash['provider']}"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
