class RelationshipUser < ActiveRecord::Migration
  def change
    add_column :relationships, :freind, :integer

    add_column :relationships, :user_id, :integer
   add_index :relationships, :user_id
  end
end
