angular
  .module('app')
  .controller('CustomersCtrl', ['Customer', '$scope', 
    function(Customer, $scope) {
      $scope.customers = Customer.query();

      $scope.save = function(customer) {
        if (!_.include($scope.todos, customer)) {
          $scope.todos.push(customer);
          customer.$save();
        } else {
          Todo.update(customer);
        }
        $scope.activeCustomer = new Customer();
      };



  }]);

