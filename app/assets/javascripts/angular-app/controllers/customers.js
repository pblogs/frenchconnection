angular
  .module('app')
  .controller('CustomersCtrl', ['Customer', '$scope', function(Customer, $scope) {
    //$scope.customers = Customer.query();
    //console.log($scope.customers);
    this.customer = customer;
    console.log('customer: ' + $scope.customer);
  }]);

  var customer = {
    name: 'OS'
  }
