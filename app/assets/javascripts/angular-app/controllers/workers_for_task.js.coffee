angular.module('orwapp').controller 'WorkersForTaskController',
["$scope", 'User', '$http', ($scope, User, $http) ->

  task_id      = $('[data-task-id]').first().data('task-id')

  # qualified_workers
  # TODO Move this to a model or something.
  $http(
    method: 'GET',
    url: '/tasks/qualified_workers',
    params: { task_id: task_id }
  ).success((data, status) ->
    $scope.workers = data
  ).error (data, status) ->
    alert('failed')
    return



  # selected_workers
  # TODO Move this to a model or something.
  $http(
    method: 'GET',
    url: '/tasks/selected_workers',
    params: { task_id: task_id }
  ).success((data, status) ->
    $scope.selected_workers = data
  ).error (data, status) ->
    alert('failed')
    return

  # select_workers
  $scope.select = (worker, index) ->
    url          = '/tasks/select_workers'
    worker_id    = worker.id
    task_id      = $('[data-task-id]').first().data('task-id')

    $scope.workers.splice(index, 1)
    $http(
      method: 'POST'
      url: url
      params: {task_id: task_id, worker_id: worker_id }
    ).success((data, status) ->
      #return
    ).error (data, status) ->
      alert('failed')
      return
    $scope.selected_workers.push worker

  $scope.remove_selected_worker = (worker, index) ->
    url          = '/tasks/remove_selected_worker'
    worker_id    = worker.id
    task_id      = $('[data-task-id]').first().data('task-id')
    $scope.selected_workers.splice(index, 1)
    $http(
      method: 'DELETE'
      url: url
      params: {task_id: task_id, worker_id: worker_id }
    ).success((data, status) ->
      #return
    ).error (data, status) ->
      alert('failed')
      return
    $scope.workers.push worker
]
