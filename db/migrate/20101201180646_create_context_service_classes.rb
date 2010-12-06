class CreateContextServiceClasses < ActiveRecord::Migration
  def self.up
    create_table :context_service_classes do |t|
      t.integer :context_id
      t.integer :service_class_id

      t.timestamps
    end
  end

  def self.down
    drop_table :context_service_classes
  end
end
