class UpdateEvent < ActiveRecord::Migration
  def change
    add_column :events, :route, :string
    add_column :events, :street_number, :integer
    add_column :events, :country, :string
    add_column :events, :postal_code, :string
  end
end
