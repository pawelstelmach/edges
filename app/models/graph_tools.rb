class GraphTools
  
  def self.get_possible_children(node, context_nodes)
    possibilities = Array.new
    context_nodes.each do |k|
      if node!=k && k["class"]!="#start"
        possibilities << {:parent => node, :child => k}
      end
    end
    possibilities
  end
  
  def self.get_possible_parents(node, context_nodes)
    possibilities = Array.new
    context_nodes.each do |k| 
      if node!=k && k["class"]!="#end"
          possibilities << {:parent => k, :child => node}
      end
    end
    possibilities
  end

  def self.get_non_coherent_nodes(functionalities)
    nodes = Array.new
    children = Array.new
    functionalities.each do |k|
      temp_children = k["child"].to_a.flatten
      temp_children.each do |kk|
        if kk!=nil 
          children << kk.to_i 
        end
      end
    end
    functionalities.each do |k|
      if k["child"]==nil && k["class"]!="#end"
        nodes << {:element => k, :missing => "child"}  
      end
      unless children.include?(k["id"].to_i) || k["class"]=="#start"
        nodes << {:element => k, :missing => "parent"}  
      end
    end
    nodes
  end
  
end