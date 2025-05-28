class AddRecoverableToXxUserIds < ActiveRecord::Migration[7.1]
  def change
    add_column :xx_user_ids, :reset_password_token, :string
    add_column :xx_user_ids, :reset_password_sent_at, :datetime
  end
end
