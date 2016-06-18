class RelationshipType < ActiveRecord::Migration
  def change
    add_column :relationships, :type, :string, :default => "Other"
  end
end
