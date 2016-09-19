class FriendId < ActiveRecord::Migration
  def change
      rename_column :relationships, :friend, :friend_id
  end
end
