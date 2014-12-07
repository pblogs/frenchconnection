angular.module('Orwapp').factory 'Inventory', ($resource) ->
  
  Inventory = $resource "/api/v1/inventories/:id",
                      { id: "@id" }

  return Inventory
