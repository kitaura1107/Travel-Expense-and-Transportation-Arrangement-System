class XxUserId < ApplicationRecord
    acts_as_paranoid # 論理削除を有効にする


    #UserIDを主キーにする
    self.primary_key = 'UserID'
    

    #UserIDの初期値を設定する
    before_create :set_user_id
    
    # 新規登録時のInsTimeを設定する
    before_create :set_ins_time
    # 更新時のUpdTimeを設定する
    before_save :set_upd_time

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
    
    # ↓ DeviseがUserIDを使って認証するようにする
    def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        where(UserID: conditions[:UserID]).first
    end

    # メールアドレスのバリデーションをスキップするためにfalseを返す
    def email_required?
        false
    end
    
    # メールアドレスの変更チェックを常にfalseにする（変更があったとみなさない）
    def email_changed?
        false
    end
    
    # email属性としてMailAdressカラムの値を返す（aliasのような役割）
    def email
        self.MailAdress
    end

    # email属性に値をセットするとMailAdressカラムにセットされるようにする
    def email=(value)
        self.MailAdress = value
    end

    private
    # 0000から始まる4桁のUserIDを設定する
    # 0001, 0002, 0003, ...と続く
    def set_user_id
        max_id = XxUserId.maximum("CAST(UserID AS UNSIGNED)")|| 0
        self.UserID = (max_id + 1).to_s.rjust(4, "0")
    end
    # InsTimeを現在時刻に設定する
    # ただし、InsTimeがnilの場合のみ
    def set_ins_time
        self.InsTime ||= Time.current
    end
    # UpdTimeを現在時刻に設定する
    # ただし、UpdTimeがnilの場合のみ
    def set_upd_time
        self.UpdTime = Time.current
    end
end
