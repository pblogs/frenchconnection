angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Restangular) ->

    $scope.customers = {}
    $scope.customer = { name: 'hei' }

    $scope.getCustomers = () ->
      Restangular.all("customers").getList().then (customers) ->
        $scope.customers = customers

    $scope.getCustomers()

    $scope.save = (customer) ->
      console.log("saving '#{customer.name}'")
      customer.save()
      $scope.getCustomers()
      #$scope.customer = {}
      #if $scope.customer.id?
      #  Customer.update($scope.customer)
      #else
      #  Customer.save($scope.customer)

    #$scope.edit = (customer) ->
    #  $scope.customer = customer.get({single: true})
    #  #$scope.customer = Customer.get({ id: customer.id })

    #$scope.delete = (customer) ->
    #  customer.$delete()
    #  $scope.getCustomers()



