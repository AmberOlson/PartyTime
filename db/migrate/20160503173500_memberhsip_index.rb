class MemberhsipIndex < ActiveRecord::Migration
  def change
    remove_index :memberships, :user_id
    remove_index :memberships, :event_id
    add_index :memberships, [ :user_id, :event_id ], :unique => true
  end
end
