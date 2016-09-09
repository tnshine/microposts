class AddOwnerToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :owner, :integer
  end
end
