class EdgesCheckerApi < ActionWebService::API::Base
  api_method :check, :expects => [:string], :returns => [:string] 
  api_method :check_ssdl, :expects => SmartServiceGraph, :returns => SmartServiceGraph
end