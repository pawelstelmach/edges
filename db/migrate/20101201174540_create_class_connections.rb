class CreateClassConnections < ActiveRecord::Migration
  def self.up
    create_table :class_connections do |t|
      t.integer :context_id
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
  end

  def self.down
    drop_table :class_connections
  end
end
