angular.module('Orwapp').controller 'ToolsController', ($scope, Inventory, $http) ->

  $scope.test = 'martin'
  $scope.tools = Inventory.query()
  $scope.selected = []

  console.log "Found inventories: #{$scope.tools}"

  $scope.select = (tool) ->
    url          = '/tasks/select_inventory'
    inventory_id = tool.id
    task_id      = $('[data-task-id]').first().data('task-id')

    # Let Rails know about the selection
    $http(
      method: 'POST'
      url: url
      params: {task_id: task_id, inventory_id: inventory_id }
    ).success((data, status) ->
      #alert('saved')
      #return
    ).error (data, status) ->
      alert('failed')
      #$scope.data = data or "Request failed"
      #$scope.status = status
      return
    
    
    # Put it in selected
    $scope.selected.push tool
 
