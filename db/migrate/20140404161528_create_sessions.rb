class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.belongs_to :user
      t.belongs_to :key
      t.string :container_host
      t.string :container_port
      t.timestamps
    end
  end
end
