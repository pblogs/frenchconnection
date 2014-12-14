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
    url          = '/tasks/select_inventory'
    inventory_id = tool.id
    task_id      = $('[data-task-id]').first().data('task-id')

    # Let Rails know about the selection
    $http(
      method: 'POST'
      url: url
      params: {task_id: task_id, inventory_id: inventory_id }
    ).success((data, status) ->
      #return
    ).error (data, status) ->
      alert('failed')
      return
    
    # Put it in selected
    $scope.selected_tools.push tool

]
