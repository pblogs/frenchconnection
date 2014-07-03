angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Restangular) ->

    Customer = Restangular.all('customers')

    $scope.customers = {}
    $scope.customers = Customer.getList()

    console.log('allUsers: ' +$scope.customers)



    #$scope.getCustomers = () ->
    #  console.log('getCustomers')
    #  Customer.query().$promise.then (customers) ->
    #    $scope.customers = customers
    #    $scope.customer = {}
    #    console.log('promise done')

    #$scope.save = () ->
    #  if $scope.customer.id?
    #    Customer.update($scope.customer)
    #  else
    #    Customer.save($scope.customer)
    #  $scope.customer = {}
    #  $scope.getCustomers()

    #$scope.edit = (customer) ->
    #  $scope.customer = Customer.get({ id: customer.id })

    #$scope.delete = (customer) ->
    #  customer.$delete()
    #  $scope.getCustomers()



