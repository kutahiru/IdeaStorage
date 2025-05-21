class Users::SessionsController < Devise::SessionsController
  def new
    redirect_to user_google_oauth2_omniauth_authorize_path, method: :post, data: { turbo: false }
  end

  def destroy
    sign_out(current_user)
    redirect_to root_path, info: "ログアウトしました"
  end
end
