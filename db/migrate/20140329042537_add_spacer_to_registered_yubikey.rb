class AddSpacerToRegisteredYubikey < ActiveRecord::Migration
  def change
    rename_column :users, :registeredyubikey, :registered_yubikey
  end
end
