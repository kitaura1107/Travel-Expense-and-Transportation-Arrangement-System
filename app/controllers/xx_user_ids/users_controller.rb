class XxUserIds::UsersController < ApplicationController
  def fetch_username
    user = XxUserId.find_by(UserID: params[:user_id])
    if user
      render json: { user_name: user.UserName }
    else
      render json: { user_name: nil }
    end
  end
end
