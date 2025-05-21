class RenameEmailToMailAdressInXxUserIds < ActiveRecord::Migration[7.1]
  def change
     # まずインデックス削除
    remove_index :xx_user_ids, name: "index_xx_user_ids_on_email"

    # カラム名変更
    rename_column :xx_user_ids, :email, :MailAdress

    # インデックスをMailAdressに追加（重複がない場合）
    add_index :xx_user_ids, :MailAdress, unique: true
  end
end
