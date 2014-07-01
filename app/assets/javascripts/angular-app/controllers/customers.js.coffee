angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Customer) ->

    $scope.getCustomers = () ->
      Customer.query().$promise.then (customers) ->
        $scope.customers = customers

