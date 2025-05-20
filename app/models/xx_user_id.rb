class XxUserId < ApplicationRecord
    #UserIDを主キーにする
    self.primary_key = 'UserID'
    

    #UserIDの初期値を設定する
    before_create :set_user_id

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    private

    def set_user_id
        max_id = XxUserId.maximum("CAST(UserID AS UNSIGNED)")|| 0
        self.UserID = (max_id + 1).to_s.rjust(4, "0")
    end

end
