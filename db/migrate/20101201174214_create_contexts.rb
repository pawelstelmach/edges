class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.integer :context_id
      t.integer :service_class_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contexts
  end
end
