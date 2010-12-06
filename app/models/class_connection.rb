class ClassConnection < ActiveRecord::Base
  named_scope :with_connection, { :include => [:parent, :child] }
  belongs_to :parent, :class_name => 'ServiceClass'
  belongs_to :child, :class_name => 'ServiceClass'
  belongs_to :context

end
