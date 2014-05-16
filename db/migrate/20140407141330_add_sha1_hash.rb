class AddSha1Hash < ActiveRecord::Migration
  def change
    add_column :keys, :sha1hash, :string
  end
end
