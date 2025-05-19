class CreateXxUserIds < ActiveRecord::Migration[7.1]
  def change
    create_table :xx_user_ids do |t|
      t.string :UserID, limit:4
      t.datetime :InsTime, null:false
      t.string :InsUserID, limit:4
      t.string :InsPGID, limit:7
      t.datetime :UpdTime, null:false
      t.string :UpdUserID, limit:4
      t.string :UpdPGID, limit: 8
      t.integer :UpdCount, default:1
      t.string :UserName, limit:40
      t.string :Password, limit:10
      t.string :UserKubun, limit:1, default:"1"
      t.string :MailAdress, limit:50, null:false

      t.timestamps
    end
  end
end
