class CreateXxmBumons < ActiveRecord::Migration[7.1]
  def change
    create_table :xxm_bumons do |t|
      t.string :BumonCD, limit:3
      t.datetime :InsTime, null:false
      t.string :InsUserID, limit:4
      t.string :InsPGID, limit:7
      t.datetime :UpdTime
      t.string :UpdUserID, limit:4
      t.string :UpdPGID, limit:8
      t.integer :UpdCount, default:"1"
      t.string :BumonName, limit:40

      t.timestamps
    end
  end
end
