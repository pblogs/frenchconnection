angular.module('Orwapp').controller 'ToolsController', ($scope, Inventory) ->

  $scope.test = 'martin'
  $scope.tools = Inventory
  $scope.selected = [ {name: 'martin'}]
  $scope.selected.push  {name: 'ciss'}

  $scope.select = (tool) ->
    console.log "Selected #{tool.name}"
    # Let Rails know about the selection
    # Put it in selected
    $scope.selected.push tool
 
