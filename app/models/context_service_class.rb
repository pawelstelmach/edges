class ContextServiceClass < ActiveRecord::Base
  belongs_to :context
  belongs_to :service_class
end
