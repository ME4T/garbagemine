class FixThingsColumnName < ActiveRecord::Migration
  def self.up
    rename_column :things, :type, :thing_type
  end

  def self.down
    rename_column :things, :thing_type, :type
  end
end
