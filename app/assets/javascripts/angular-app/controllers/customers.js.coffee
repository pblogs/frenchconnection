angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Customer) ->

    $scope.getCustomers = () ->
      Customer.query().$promise.then (customers) ->
        $scope.customers = customers

    $scope.save = () ->
      Customer.save($scope.customer)
      $scope.customer = {}
      $scope.getCustomers()

    $scope.edit = (customer) ->
      $scope.customer = Customer.get({ id: customer.id })



