class CreateStar < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :user_id
      t.string :wiki_name
    end
  end
end
