class AddSshLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ssh_login, :string
  end
end
