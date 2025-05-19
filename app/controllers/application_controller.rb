class ApplicationController < ActionController::Base
     protected

  def after_sign_in_path_for(resource)
    # ログイン後に遷移したいパスを指定するよ
    menu_path  # 例えばメニュー画面に飛ばしたい場合
  end
end
