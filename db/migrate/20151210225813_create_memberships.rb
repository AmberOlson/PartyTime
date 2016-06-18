class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.binary :admin
      t.string :status
      t.integer :user_id
      t.integer :event_id
      t.timestamps
    end

    add_index :memberships, :event_id
    add_index :memberships, :user_id
  end
end
