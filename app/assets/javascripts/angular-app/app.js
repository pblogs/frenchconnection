angular
  .module('app', ['ngRoute', 'ngResource'])
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/', {
      controller: 'MainCtrl'
    }).when('/:status', {
      controller: 'HomeCtrl',
    }).otherwise({
      redirectTo: '/'
    });
  }]);

