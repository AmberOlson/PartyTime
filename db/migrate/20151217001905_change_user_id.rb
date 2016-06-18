class ChangeUserId < ActiveRecord::Migration
  def change
    change_column :comments, :user_id,  :text
  end
end
