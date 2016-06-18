class AddEventIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :event_id, :integer
    add_index :users, :event_id
  end
end
