class AddRememberableToXxUserIds < ActiveRecord::Migration[7.1]
  def change
    add_column :xx_user_ids, :remember_created_at, :datetime
  end
end
