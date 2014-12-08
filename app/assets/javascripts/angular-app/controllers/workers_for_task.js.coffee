angular.module('Orwapp').controller 'WorkersForTaskController',
["$scope", ($scope, User, $http) ->

  $scope.workers = User.query()
  console.log "Found workers: #{$scope.workers}"

  # TODO Populate this with @task.users when initializing
  $scope.selected_workers = []

  $scope.select = (worker, index) ->
    url          = '/tasks/select_workers'
    worker_id    = worker.id
    task_id      = $('[data-task-id]').first().data('task-id')

    # Remove selected worker from the workers array
    $scope.workers.splice(index, 1)

    # Let Rails know about the selection
    $http(
      method: 'POST'
      url: url
      params: {task_id: task_id, worker_id: worker_id }
    ).success((data, status) ->
      #return
    ).error (data, status) ->
      alert('failed')
      return
    
    # Put it in selected
    $scope.selected_workers.push worker
] 
