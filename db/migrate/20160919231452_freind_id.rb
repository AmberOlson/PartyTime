class FreindId < ActiveRecord::Migration
  def change
      change_column :relationships, :friend, :integer
  end
end
