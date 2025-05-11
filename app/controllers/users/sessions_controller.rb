class Users::SessionsController < Devise::SessionsController
  def new
    redirect_to user_google_oauth2_omniauth_authorize_path, method: :post, data: { turbo: false }
  end
end
