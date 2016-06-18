class ChangeAdmin < ActiveRecord::Migration
  def change
    change_column :memberships, :admin , :boolean, default: false
  end
end
