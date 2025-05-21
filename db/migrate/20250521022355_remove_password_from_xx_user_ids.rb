class RemovePasswordFromXxUserIds < ActiveRecord::Migration[7.1]
  def change
    remove_column :xx_user_ids, :password, :string
  end
end
