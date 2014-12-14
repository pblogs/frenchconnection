angular.module('orwapp').controller 'ToolsController',
['$scope', 'Inventory', '$http', ($scope, Inventory, $http) ->
  

  # Fetch all available inventories
  $scope.inventories = Inventory.query()
  task_id      = $('[data-task-id]').first().data('task-id')

  # Popululate selected_inventories with @task.inventories
  $http(
    method: 'GET',
    url: '/tasks/selected_inventories',
    params: { task_id: task_id }
  ).success((data, status) ->
    $scope.workers = data
    $scope.selected_inventories = data
  ).error (data, status) ->
    alert('failed')
    return

  $scope.select = (inventory, index) ->
    url          = '/tasks/select_inventory'
    inventory_id = inventory.id
    task_id      = $('[data-task-id]').first().data('task-id')
    $http(
      method: 'POST'
      url: url
      params: { task_id: task_id, inventory_id: inventory_id }
    ).success((data, status) ->
      $scope.inventories.splice(index, 1)
      $scope.selected_inventories.push inventory
    ).error (data, status) ->
      alert('failed')
      return


  ## Figure out why this error occours from time to time:
  # Test by adding and removing tools multiple times.
  #
  ## Error: [ngRepeat:dupes] Duplicates in a repeater are not allowed. 
  # Use 'track by' expression to specify unique keys. 
  # Repeater: inventory in inventories track by inventory.id | filter:searchText, 
  # Duplicate key: 14, Duplicate value: {"id":14,"name":"Concrete blender",
  # "description":"5 tons of Cat","certificates_id":null,


  $scope.remove_selected_inventory = (inventory, index) ->
      url          = '/tasks/remove_selected_inventory'
      inventory_id    = inventory.id
      task_id      = $('[data-task-id]').first().data('task-id')
      $http(
        method: 'DELETE'
        url: url
        params: {task_id: task_id, inventory_id: inventory_id }
      ).success((data, status) ->
        $scope.selected_inventories.splice(index, 1)
        $scope.inventories.push inventory
      ).error (data, status) ->
        alert('failed')
        return
  
]
