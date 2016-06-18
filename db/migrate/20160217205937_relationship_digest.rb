class RelationshipDigest < ActiveRecord::Migration
  def change
    add_column :memberships, :invitiation_token, :string, :unique => true
  end
end
