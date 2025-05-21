class AddEncryptedPasswordAndChangePasswordLimitToXxUserIds < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:xx_user_ids, :encrypted_password)
      add_column :xx_user_ids, :encrypted_password, :string, default: "", null: false
    end

    change_column :xx_user_ids, :password, :string, limit: 10
  end
end
