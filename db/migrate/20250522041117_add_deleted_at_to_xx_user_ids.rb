class AddDeletedAtToXxUserIds < ActiveRecord::Migration[7.1]
  def change
    add_column :xx_user_ids, :deleted_at, :datetime
    add_index :xx_user_ids, :deleted_at
  end
end
