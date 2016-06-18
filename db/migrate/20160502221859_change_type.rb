class ChangeType < ActiveRecord::Migration
  def change
    rename_column :relationships, :type, :classification 
  end
end
