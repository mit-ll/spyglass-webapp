class ChangeUseYubikeyName < ActiveRecord::Migration
  def change
    rename_column :users, :useyubikey, :use_yubikey
  end
end
