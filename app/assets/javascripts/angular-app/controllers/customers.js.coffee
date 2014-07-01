angular
  .module('app')
  .controller "CustomersCtrl", ($scope, Customer) ->
    console.log('hi')

    $scope.getCustomers = () ->
      Customer.query().$promise.then (customers) ->
        console.log('promise')
        $scope.customers = customers

#angular
#  .module('app')
#  .controller("CustomersCtrl", ($scope,Customer) -> $scope.getCustomers= () ->
#    console.log 'her'
#    Customer.query().$promise.then (customers) ->
#      $scope.customers = customers
#  )

## angular
##   .module('app')
##   .controller('CustomersCtrl', ['Customer', '$scope', 
##     function(Customer, $scope) {
##       this.customer = {};
## 
##       this.save = function(customer) {
##         this.customer = {};
##       };
## 
##       $scope.getCustomers = () ->
##         $scope.customers = Customer.query()
## 
## 
## 
##   }]);
## 
