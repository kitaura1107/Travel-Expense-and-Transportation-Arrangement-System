class AddIndexToXxUserIdsEmail < ActiveRecord::Migration[7.1]
  def change
      add_index :xx_user_ids, :email, unique: true
  end
end
