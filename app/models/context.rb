class Context < ActiveRecord::Base
  has_many :context_service_classes
  has_many :service_classes, :through => :context_service_classes
  has_many :class_connections
  
 def create_service_classes( val_array )
   service_classes_set = Set.new
   val_array.each do |v|
     temp = v.split("-")
      temp.each do |v|
        service_classes_set << (ServiceClass.find_by_name(v) || ServiceClass.new(:name => v))
      end
  end
  self.service_classes = service_classes_set.to_a
  print "\n\n\n!!!"
  print self.service_classes.inspect 
    print "!!!\n\n\n"
  self.save
end

    #print "service_classes_form setter\n\n"
    #print "Value: #{val}\n\n"
    #val = val.gsub(" ", "")
    #val_array = val.split(",")
    #val_array.each do |v|
    #  self.service_classes << (ServiceClass.find_by_name(v) || ServiceClass.new(:name => v))
    #end
    #self.save
 # end
  
  #def service_classes_form
   # sc = ""
    #self.service_classes.each do |c| sc+="#{c.name}, " end
    #sc
  #end
  
  def class_connections_form=( val )
    val = val.gsub(" ", "")
    val_array = val.split(";")
    create_service_classes(val_array)
    self.class_connections.clear
    val_array.each do |v|
      temp = v.split("-")
      parent = ServiceClass.all.detect do |i| i.name==temp.first end
      child = ServiceClass.all.detect do |i| i.name==temp.second end
      self.class_connections.build(:parent => parent, :child => child)
    end
    self.save
   end
  
  def class_connections_form
    cc = ""
    self.class_connections.each do |c| cc+="#{c.parent.name}-#{c.child.name}; " end
    cc
  end
  
end
