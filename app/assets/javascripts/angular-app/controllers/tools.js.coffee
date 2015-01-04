angular.module('orwapp').controller 'ToolsController',
['$scope', 'Inventory', '$http', ($scope, Inventory, $http) ->
  

  # Fetch all available inventories, except what's already chosen.

  # @jakub, can you show me how I implement this?
  # -> $scope.inventories = Inventory.query(task_id: task_id)
  # That should return Inventory.all minus @task.inventories
  # I can create an API endpoint that returns the correct inventories, but I'm
  # not sure how to add params to the query() method.

  task_id      = $('[data-task-id]').first().data('task-id')

  $scope.inventories = Inventory.query(task_id: task_id)

  # Popululate selected_inventories with @task.inventories
  $http(
    method: 'GET',
    url: '/tasks/selected_inventories',
    params: { task_id: task_id }
  ).success((data, status) ->
    $scope.selected_inventories = data
  ).error (data, status) ->
    alert('failed')
    return

  $scope.select = (inventory, index) ->
    url          = '/tasks/select_inventory'
    inventory_id = inventory.id

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


  $scope.remove_selected_inventory = (inventory, index) ->
      url          = '/tasks/remove_selected_inventory'
      inventory_id    = inventory.id
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
