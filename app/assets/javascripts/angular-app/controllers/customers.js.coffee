angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Restangular) ->

    # Initalize the Customer object
    Customer = Restangular.all('customers');

    $scope.customers = {}
    $scope.customer = { name: 'hei' }

    $scope.getCustomers = () ->
      Customer.getList().then (customers) ->
        $scope.customers = customers

    $scope.getCustomers()

    $scope.save = (customer) ->
      if customer.id?
        customer.save().then (customer) ->
          $scope.getCustomers()
          $scope.customer = {}
      else
        Customer.post(customer).then (customer) ->
          $scope.getCustomers()
          $scope.customer = {}


    $scope.edit = (customer) ->
      Customer.get(customer.id).then (customer) ->
        $scope.customer = customer

    $scope.delete = (customer) ->
      customer.remove().then (customer) ->
        $scope.getCustomers()



