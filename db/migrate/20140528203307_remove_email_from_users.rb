class RemoveEmailFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    rename_column :users, :ssh_login, :login
  end
end
