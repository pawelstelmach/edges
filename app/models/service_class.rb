class ServiceClass < ActiveRecord::Base
  has_many :context_service_classes
  has_many :contexts, :through => :context_service_classes
  has_many :class_connections_as_parent, :foreign_key => 'parent_id', :class_name => 'ClassConnection'
  has_many :class_connections_as_child, :foreign_key => 'child_id', :class_name => 'ClassConnection'
end

