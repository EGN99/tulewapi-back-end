class RenameFirstNameToUsernameForUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :first_name, :username
  end
end
