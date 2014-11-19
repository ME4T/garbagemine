class DropVotes < ActiveRecord::Migration
  def up
    drop_table :votes
  end

  def down
    create_table :votes do |t|
      t.integer :user_id
      t.integer :thing_id
      t.integer :creative
      t.integer :beautiful
      t.integer :inspiring

      t.timestamps      
    end

  end
end
