class AddIndexToUser < ActiveRecord::Migration
  def change
    add_index :users, [:provider, :openid], unique: true
  end
end
