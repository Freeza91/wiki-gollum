class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :provider
      t.string :name
      t.integer :role
      t.string :avator
      t.string :openid

      t.timestamps null: false
    end
  end
end
