class AddContainerHashToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :container_hashid, :text
  end
end
