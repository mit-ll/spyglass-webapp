class AddYubikeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :useyubikey, :boolean
    add_column :users, :registeredyubikey, :string
  end
end
