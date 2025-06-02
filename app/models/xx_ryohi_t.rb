class XxRyohiT < ApplicationRecord
  
  # アソシエーション・属性定義
 
  belongs_to :xxm_bumon, foreign_key: 'BumonID', primary_key: 'BumonCD', optional: true
  belongs_to :user, class_name: 'XxUserId', foreign_key: 'ShinseiID', optional: true

  # alias を使って見た目の属性名を分かりやすく
  alias_attribute :UserID, :ShinseiID
  alias_attribute :BumonCD, :BumonID

  # メール送信用の一時フラグ（コントローラー側から渡される）
  attr_accessor :current_role, :send_to_tako, :send_to_employee

  # コールバック

  before_create :set_ins_time                 # 新規登録時の登録日時
  before_save   :set_upd_time, :check_mail_flags # 更新日時・メール判定
  after_commit  :send_mail_if_needed          # 保存完了後にメール送信

  # 公開メソッド

  # 伝票番号を日付＋連番で生成
  def invoice_number
    set_travel_id
  end

  # メール送信判定ロジック

  def check_mail_flags
    self.send_to_tako = false
    self.send_to_employee = false

    # 更新前の値（変更前）を取得
    before_attrs = self.saved_changes.transform_values(&:first) if persisted?

    if current_role == "employee"
      # 社員が確定「Y」にしたとき or 内容を変更したとき → タコへ通知
      if self.KakuteiFlag == "0" && (before_attrs.nil? || before_attrs["KakuteiFlag"] != "0")
        self.send_to_tako = true
      else
        # 入力変更チェック（基本情報）
        changed_fields = %w[RyohiTName RyohiDeatil BumonID ShinseiID Sakuban]
        changed = changed_fields.any? do |field|
          old_val = before_attrs ? before_attrs[field] : nil
          current_val = self.send(field).to_s.strip
          old_val.to_s.strip != current_val
        end
        self.send_to_tako ||= changed
      end
    end

    if current_role == "tako"
      # タコがタコ確定「Y」にしたとき → 社員へ通知
      if self.TKakuteiFlag == "0" && (before_attrs.nil? || before_attrs["TKakuteiFlag"] != "0")
        self.send_to_employee = true
      end
    end
  end

  # メール送信処理

  def send_mail_if_needed
    TravelRequestMailer.notify_tako(self).deliver_later     if send_to_tako
    TravelRequestMailer.confirm_to_employee(self).deliver_later if send_to_employee
  end
  
  private

  # 伝票番号を「日付 + 連番」で生成（例：20250602001）
  def set_travel_id
    today_prefix = Date.today.strftime("%Y%m%d")
    latest_ref = XxRyohiT.where("RefNO LIKE ?", "#{today_prefix}%")
                         .order(RefNO: :desc)
                         .limit(1)
                         .pluck(:RefNO)
                         .first

    next_number = latest_ref ? latest_ref[-3..].to_i + 1 : 1
    self.RefNO = today_prefix + next_number.to_s.rjust(3, '0')
  end

  # 作成日時を現在に（初回登録時のみ）
  def set_ins_time
    self.InsTime ||= Time.current
  end

  # 更新日時を常に現在に
  def set_upd_time
    self.UpdTime = Time.current
  end
end
