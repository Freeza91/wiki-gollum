class ChangeUserProviderFromStringToInteger < ActiveRecord::Migration
  def change
    change_column :users, :provider, :integer
  end
end
