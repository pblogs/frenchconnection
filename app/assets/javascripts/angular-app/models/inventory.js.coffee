angular.module('Orwapp').factory 'Inventory', ['$resource', ($resource) ->
  
  Inventory = $resource "/api/v1/inventories/:id",
                      { id: "@id" }

  return Inventory
]
