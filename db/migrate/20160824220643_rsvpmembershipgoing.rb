class Rsvpmembershipgoing < ActiveRecord::Migration
  def change
       change_column_default :memberships, :status, "Invited"
  end
end
