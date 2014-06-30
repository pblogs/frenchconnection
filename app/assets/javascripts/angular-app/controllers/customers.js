angular
  .module('app')
  .controller('CustomersCtrl', ['Customer', '$scope', 
    function(Customer, $scope) {
      this.customer = {};

      this.save = function(customer) {
        this.customer = {};
      };


      //$scope.customers = Customer.query();

      //$scope.save = function(customer) {
      //  if (!_.include($scope.todos, customer)) {
      //    $scope.todos.push(customer);
      //    customer.$save();
      //  } else {
      //    Customer.update(customer);
      //  }
      //  $scope.activeCustomer = new Customer();
      //};


      //$scope.activeCustomer = new Customer();

      //$scope.edit = function(todo) {
      //  $scope.activeCustomer = todo;
      //};


  }]);

