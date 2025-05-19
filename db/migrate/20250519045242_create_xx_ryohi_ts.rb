class CreateXxRyohiTs < ActiveRecord::Migration[7.1]
  def change
    create_table :xx_ryohi_ts do |t|
      t.string :RefNO, limit:9
      t.datetime :InsTime, null:false
      t.string :InsUserID, limit:4
      t.string :InsPGID, limit:7
      t.datetime :UpdTime, null:false
      t.string :UpdUserID, limit:4
      t.string :UpdPGID, limit:8
      t.integer :UpdCount, default:1
      
      t.string :RyohiTName, limit:100
      t.string :RyohiDeatil, limit:500
      t.string :BumonID, limit:3
      t.string :ShinseiID, limit:4
      t.string :Sakuban, limit:15, null:false
      t.string :KakuteiFlag, limit:1, default:"0"
      t.datetime :KakuteiDate, null:false
      t.string :TehaiiDetail, limit:500
      t.integer :Fare, default:0
      t.integer :tax, default:0
      t.string :TKakuteiFlag, limit:1, default:"0"

      t.timestamps
    end
  end
end
