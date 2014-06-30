angular
  .module('app')
  .factory('Customer', function($resource) {

    var Customer = $resource('/api/v1/customers/:id.json', {id: '@id'}, {
      update: {
        method: 'PUT'
      }
    });

    return Customer;
  });

