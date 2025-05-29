class ChangeDefaultKakuteiFlagInXxRyohiTs < ActiveRecord::Migration[7.1]
  def change
    change_column_default :xx_ryohi_ts, :KakuteiFlag, from: "0", to: "1"
  end
end
