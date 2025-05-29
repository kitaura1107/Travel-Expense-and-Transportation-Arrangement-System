class XxRyohiT < ApplicationRecord
  belongs_to :xxm_bumon, foreign_key: 'BumonID', primary_key: 'BumonCD', optional: true
  
  # ユーザIDを参照するためのアソシエーション
  alias_attribute :UserID, :ShinseiID
  
  # 部門IDを参照するためのアソシエーション
  alias_attribute :BumonCD, :BumonID

  # 新規登録時のInsTimeを設定する
  before_create :set_ins_time
  # 更新時のUpdTimeを設定する
  before_save :set_upd_time

  def invoice_number
    self.set_travel_id
  end

  private

  def set_travel_id
    today_prefix = Date.today.strftime("%Y%m%d")
    latest = XxRyohiT.where("RefNO LIKE ?", "#{today_prefix}%")
                     .order(RefNO: :desc)
                     .limit(1)
                     .pluck(:RefNO)
                     .first

    next_number = if latest.present?
                    latest[-3..].to_i + 1
                  else
                    1
                  end

    self.RefNO = today_prefix + next_number.to_s.rjust(3, '0')
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
