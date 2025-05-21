class RenameEncryptedPasswordToPassword < ActiveRecord::Migration[7.1]
  def change
     rename_column :xx_user_ids, :encrypted_password, :password
  end
end
