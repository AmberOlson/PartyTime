class AddAdminDefault < ActiveRecord::Migration
  def change
     change_column_default :memberships, :admin, 0
  end
end
