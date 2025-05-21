class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインイン時に許可したいパラメーターを追加
    devise_parameter_sanitizer.permit(:sign_in, keys: [:UserID, :UserName])
    
    # サインアップ時なども必要ならここで許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:UserID, :UserName])
  end

  def after_sign_in_path_for(resource)
    # ログイン後に遷移したいパスを指定するよ
    menu_path  # 例えばメニュー画面に飛ばしたい場合
  end
end
