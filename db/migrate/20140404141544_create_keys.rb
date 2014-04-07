class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.belongs_to :user, index: true
      t.string     :keyname
      t.string     :sshkey
      t.timestamps
    end
  end
end
