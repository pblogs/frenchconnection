angular
  .module('app')
  .controller 'CustomersCtrl', ['$scope', 'Restangular', 'helloWorldFromService', ($scope, Restangular, helloWorldFromService) ->
    # Initalize the Customer object
    Customer = Restangular.all('customers')

    #console.log('hello': helloWorldFromService.sayHello())

    $scope.customers = {}
    $scope.customer = { name: 'hei' }

    $scope.callNotify = (msg) ->
      notify(msg)

    $scope.getCustomers = () ->
      Customer.getList().then (customers) ->
        $scope.customers = customers


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
]
  #.factory "notify", [
  #  "$window"
  #  (win) ->
  #    msgs = []
  #    return (msg) ->
  #      msgs.push msg
  #      if msgs.length is 3
  #        win.alert msgs.join("\n")
  #        msgs = []
  #      return
  #]

