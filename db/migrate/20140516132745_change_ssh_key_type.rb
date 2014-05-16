class ChangeSshKeyType < ActiveRecord::Migration
  def change
    change_column :keys, :sshkey, :text
  end
end
