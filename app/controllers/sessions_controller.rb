class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    email = auth["info"]["email"]

    if AdminUser.exists?(email: email)
      session[:admin_email] = email
      redirect_to admin_dashboard_path
    else
      redirect_to admin_path, alert: "Unauthorized access"
    end
  end
end
