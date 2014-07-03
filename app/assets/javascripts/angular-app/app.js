angular
  .module('app', ['ngRoute', 'restangular'])

   //.config(function (RestangularProvider, baseRequestConfig, $routeProvider, urlsProvider) {
  //    })

  .config(['$routeProvider', 'RestangularProvider', function($routeProvider, RestangularProvider) {
    RestangularProvider.setBaseUrl('/api/v1');
    $routeProvider.when('/', {
      controller: 'MainCtrl'
    }).when('/:status', {
      controller: 'HomeCtrl',
    }).otherwise({
      redirectTo: '/'
    });
  }]);

  // .config(function(RestangularProvider) {
  // });


