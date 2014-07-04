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
      Customer.post(customer).then (customer) ->
        $scope.getCustomers()
        $scope.customer = {}




    #$scope.edit = (customer) ->
    #  $scope.customer = customer.get({single: true})
    #  #$scope.customer = Customer.get({ id: customer.id })

    $scope.delete = (customer) ->
      customer.remove().then (customer) ->
        $scope.getCustomers()



