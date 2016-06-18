class AddEventColoum < ActiveRecord::Migration
  def change
     add_column :events, :provence, :string
     add_column :events, :city, :string
  end
end
