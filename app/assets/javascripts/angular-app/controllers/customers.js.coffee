angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Restangular) ->

    # Initalize the Customer object
    Customer = Restangular.all('customers');

    $scope.customers = {}
    $scope.customer = { name: 'hei',
                        #phone: '8787',
                        #org_nr: '989',
                        #address: '989',
                        #contact_person: '9898'
    }

    $scope.getCustomers = () ->
      console.log('getCustomers')
      Customer.getList().then (customers) ->
        $scope.customers = customers
        console.log("found customers: #{customers}")

    $scope.getCustomers()

    $scope.save = (customer) ->
      Customer.post(customer).then (customer) ->
        $scope.getCustomers()
        $scope.customer = {}




    #$scope.edit = (customer) ->
    #  $scope.customer = customer.get({single: true})
    #  #$scope.customer = Customer.get({ id: customer.id })

    #$scope.delete = (customer) ->
    #  customer.$delete()
    #  $scope.getCustomers()



