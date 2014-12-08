angular.module('Orwapp').factory 'User', ['$resource', ($resource) ->
  
  # Only workers for now
  User = $resource "/tasks/qualified_workers"

  return User
]
