angular.module('Orwapp').controller 'ToolsController', ($scope, Inventory, $http) ->

  $scope.test = 'martin'
  $scope.tools = Inventory
  $scope.selected = [ {name: 'martin'}]
  $scope.selected.push  {name: 'ciss'}

  $scope.select = (tool) ->
    console.log "Selected #{tool.name}"
    url = '/tasks/select_inventory'

    # Let Rails know about the selection
    $http(
      method: 'POST'
      url: url
      params: {id: 2}
    ).success((data, status) ->
      alert('saved')
      return
    ).error (data, status) ->
      alert('failed')
      #$scope.data = data or "Request failed"
      #$scope.status = status
      return
    
    return
    
    # Put it in selected
    $scope.selected.push tool
 
