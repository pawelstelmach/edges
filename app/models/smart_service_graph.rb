class SmartServiceGraph < ActionWebService::Struct
  member :nodes, [SmartServiceNode]
  member :inputdata, [SmartServiceInputVariable]
  member :parameters, SmartServiceParameters
  member :qos, SmartServiceQos
  member :mediators, [SmartServiceMediator]
end