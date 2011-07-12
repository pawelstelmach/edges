class EdgesCheckerController < ApplicationController
  wsdl_service_name 'EdgesChecker'
  web_service_api EdgesCheckerApi
  web_service_scaffold :invocation if Rails.env == 'development'


def check_ssdl(smartservicegraph)
  #TODO: Must implement ssdl translation to apropriet form
  return smartservicegraph 
end

def check(xml)
  @functionalities = Hash.from_xml(xml)['functionalities']['functionality'].to_a
  print @functionalities.inspect
  @new_functionalities = concepts_similarity_algorithm( @functionalities )
  
  return generate_functionalities_result_xml(@functionalities)
  
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
  
  def generate_functionalities_result_xml(functionalities)
    result = ""
    xml_build = Builder::XmlMarkup.new(:target => result, :ident => 2 )
    xml_build.instruct! 
    xml_build.functionalities {
      functionalities.each do |p, u|
      xml_build.functionality {
      xml_build.id(p["id"])
      xml_build.name(p["name"])
      xml_build.class(p["class"])
      p["child"].to_a.flatten.each do |c|
        xml_build.child(c)
      end
      p["input"].to_a.flatten.each do |t|
        xml_build.input(t)
      end
      p["output"].to_a.flatten.each do |t|
        xml_build.output(t)
      end
      }
    end
    }
    return result
  end
end
