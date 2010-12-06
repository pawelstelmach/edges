# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery :except => [:run]# See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def run

  #@experiment = Hash.from_xml( xml )['request']
  
  #non_coherent_nodes = get_non_coherent_nodes(@functionalities)
  #if non_coherent_nodes.empty?
  #  print xml#return xml
  #end
  #n1 = non_coherent_nodes.second

  #print @functionalities.size
  #print "\n\n"
  #array = n1[:missing]=="child" ? possible_children(n1[:element], @functionalities) : possible_parents(n1[:element], @functionalities)
  #array.each do |k|
  #  print "\n#{k[:parent]["id"]} -> #{k[:child]["id"]} \n\n"
  #end
  #@functionalities = Hash.from_xml( xml )['request']['functionalities']['functionality']
  @functionalities = Hash.from_xml(params[:sla])['functionalities']['functionality'].to_a
  print @functionalities.inspect
  @new_functionalities = concepts_similarity_algorithm( @functionalities )
  
  render 'show_functionalities.xml.erb', :layout => false
  
end

private
  def concepts_similarity_algorithm(functionalities)
    non_coherent_nodes = GraphTools.get_non_coherent_nodes(functionalities)
    if non_coherent_nodes.empty?
      return functionalities
    end
    print "#{non_coherent_nodes.size}\n\n\n"
    new_connections = Array.new
    non_coherent_nodes.each do |n|
      possible_connections = n[:missing]=="child" ? GraphTools.get_possible_children(n[:element], @functionalities) : GraphTools.get_possible_parents(n[:element], @functionalities)
      possible_connections.each do |c|
        c.store(:match, ContextTools.evaluate_connection_match(c, @functionalities))
      end
      #
      new_connections << ContextTools.choose_best_connection(possible_connections, n)
    end

    new_connections.each do |c|
      print "\n\nParent: #{c[:parent].nil? ? "nil" : c[:parent]["name"]}, Child: #{c[:child].nil? ? "nil" : c[:child]["name"]}\n\n"
    end
    add_node_connections(functionalities, new_connections, 1)
  end
  
  def add_node_connections(functionalities, new_connections, mode)
    new_connections.each do |c|
      functionalities.each do |f|
        if mode==1 #zaspokaja tylko wymagania danych na wejściu
         if f["id"].to_i==c[:parent]["id"].to_i
           f["child"]=f["child"].to_a.flatten
           f["child"] << c[:child]["id"]
         end
        else #dba o prawidłową kolejność (więcej krawędzi)
         if f["class"]==c[:parent]["class"]
           f["child"]=f["child"].to_a.flatten
           f["child"] << c[:child]["id"]
         end
        end
      end
    end
    functionalities
  end
  
  end
  
