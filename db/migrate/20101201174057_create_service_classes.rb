class CreateServiceClasses < ActiveRecord::Migration
  def self.up
    create_table :service_classes do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :service_classes
  end
end
