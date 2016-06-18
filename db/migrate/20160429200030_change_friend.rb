class ChangeFriend < ActiveRecord::Migration
  def change
    rename_column :relationships, :freind, :friend
  end
end
