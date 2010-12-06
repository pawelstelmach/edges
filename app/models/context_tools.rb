class ContextTools
  
  #do przeniesienia gdy pojawi się więcej metod
  def self.evaluate_context_similarity(context1, context2)
    context1 = context1.service_classes.to_set
    context2 = context2.service_classes.to_set
    (context1 & context2).size-((context1 | context2)-(context1 & context2)).size
  end
   
  def self.choose_best_connection(connections, node)
    best = connections.first;
    connections.each do |k|
      if k[:match] > best[:match]
        best = k
      end
    end
    if best[:match] < -100#minimum_match
      if node[:missing]=="child"
        best = connections.detect do |i| i[:child]["class"]=="#end" end    
      else
        best = connections.detect do |i| i[:parent]["class"]=="#start" end
      end
      best[:match] = 0
    end
    best
  end
  
  def self.functionalities_to_context(functionalities)
    context = Context.new
    functionalities.each do |f|
      context.service_classes << (ServiceClass.find_by_name(f["class"]) || ServiceClass.new(:name => f["class"])) 
    end
    context
  end
  
  def self.evaluate_connection_match(connection, functionalities)
    match_value = 0
    
    parent = ServiceClass.find_by_name(connection[:parent]["class"])
    child = ServiceClass.find_by_name(connection[:child]["class"])
    
    if parent!=nil && child!=nil
      contexts = Context.all
      contexts_to_eval = Array.new
      current_context = functionalities_to_context(functionalities)
      
      contexts.each do |c|
        c.class_connections.each do |cc|
          if cc.parent==parent && cc.child==child
            contexts_to_eval << c
          end
        end
      end
      
      contexts_to_eval.each do |c|
        match_value += evaluate_context_similarity(current_context, c)
      end
    else
      match_value = -999999
    end
      match_value
   end
  
end