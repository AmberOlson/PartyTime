class Unique < ActiveRecord::Migration
  def change
    remove_index :relationships, :user_id
    add_index :relationships, [ :user_id, :friend ], :unique => true
  end
end
