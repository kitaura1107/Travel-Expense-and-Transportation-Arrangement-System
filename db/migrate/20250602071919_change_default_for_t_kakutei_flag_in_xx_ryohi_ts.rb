class ChangeDefaultForTKakuteiFlagInXxRyohiTs < ActiveRecord::Migration[7.1]
  def change
    change_column_default :xx_ryohi_ts, :TKakuteiFlag, from: "0", to: "1"
  end
end
