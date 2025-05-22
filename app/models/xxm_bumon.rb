class XxmBumon < ApplicationRecord
  # 新規登録時のInsTimeを設定する
  before_create :set_ins_time
  # 更新時のUpdTimeを設定する
  before_save :set_upd_time


  private

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
