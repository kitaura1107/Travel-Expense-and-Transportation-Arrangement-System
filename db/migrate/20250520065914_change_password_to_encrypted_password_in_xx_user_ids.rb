class ChangePasswordToEncryptedPasswordInXxUserIds < ActiveRecord::Migration[7.1]
  def change
    remove_column :xx_user_ids, :Password, :string
    add_column :xx_user_ids, :encrypted_password, :string, null: false, default: ""
  end
end
