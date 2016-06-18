class RelationshipNewstring < ActiveRecord::Migration
  def change
    change_column :relationships, :friend,  :string
  end
end
