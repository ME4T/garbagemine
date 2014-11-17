class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :parent_id
      t.integer :user_id
      t.integer :bounty
      t.string :text
      t.string :type
      t.string :url

      t.timestamps
    end
  end
end
