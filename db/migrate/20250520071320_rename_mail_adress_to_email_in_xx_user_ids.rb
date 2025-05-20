class RenameMailAdressToEmailInXxUserIds < ActiveRecord::Migration[7.1]
  def change
     rename_column :xx_user_ids, :MailAdress, :email
  end
end
