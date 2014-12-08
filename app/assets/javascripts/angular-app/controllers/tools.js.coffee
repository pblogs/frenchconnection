angular.module('Orwapp').controller 'ToolsController', ['$scope', '$http', 'Inventory', ($scope, Inventory, $http) ->
  

  $scope.test = 'martin'
  $scope.tools = Inventory.query()
  $scope.selected_tools = []

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
      #return
    ).error (data, status) ->
      alert('failed')
      return
    
    # Put it in selected
    $scope.selected_tools.push tool

]
