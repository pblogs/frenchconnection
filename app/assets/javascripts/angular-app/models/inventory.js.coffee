angular.module('Orwapp').factory 'Inventory', ($resource) ->


  Inventory = $resource "/api/v1/inventories/:id",
                      { id: "@id" }

  return Inventory










  #return [
  #  { name: 'Cat bulldozer' },
  #  { name: 'Kamatzu crane' }
  #]
