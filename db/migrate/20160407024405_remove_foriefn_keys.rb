class RemoveForiefnKeys < ActiveRecord::Migration
  def change
    remove_column :events, :user_id
    remove_column :users, :event_id
  end
end
