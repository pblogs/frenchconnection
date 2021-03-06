angular.module('orwapp').controller 'ToolsController',
['$scope', 'Inventory', '$http', ($scope, Inventory, $http) ->
  
  task_id = $('[data-task-id]').first().data('task-id')
  $scope.inventories = Inventory.query(task_id: task_id)

  # Populate selected_inventories with @task.inventories
  $http(
    method: 'GET',
    url: '/tasks/selected_inventories',
    params: { task_id: task_id }
  ).success((data, status) ->
    $scope.selected_inventories = data
  ).error (data, status) ->
    alert('failed')
    return

  # select_inventory
  $scope.select  = (inventory) ->
    url          = '/tasks/select_inventory'
    inventory_id = inventory.id
    $http(
      method: 'POST'
      url: url
      params: { task_id: task_id, inventory_id: inventory_id }
    ).success((data, status) ->
      _.remove $scope.inventories, (i) ->
        i.id == inventory.id
      $scope.selected_inventories.push(inventory)
    ).error (data, status) ->
      alert('failed')
      return


  # remove_selected_inventory
  $scope.remove_selected_inventory = (inventory, index) ->
      url          = '/tasks/remove_selected_inventory'
      inventory_id = inventory.id
      $http(
        method: 'DELETE'
        url: url
        params: {task_id: task_id, inventory_id: inventory_id }
      ).success((data, status) ->
        $scope.selected_inventories.splice(index, 1)
        $scope.inventories.push(inventory)
      ).error (data, status) ->
        alert('failed')
        return
  
]
