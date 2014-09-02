app = angular.module 'app'
app.directive 'starred', () ->
  restrict: 'E'
  templateUrl: '/templates/starred.html.slim'
  controller: ($scope) ->
    $scope.star_clicked = (e) ->
      console.log e.target
      target = e.target
      #console.log e
      id = $(target).closest('tr').data('customer-id')
      console.log "id: #{id}"

      #if angular.element('#page_wrapper input[type="text"]').size() > 0
      #  angular.element('#page_wrapper input[type="text"]')
      #    .attr('type', 'password')
      #else
      #  angular.element('#page_wrapper input[type="password"]')
      #    .attr('type', 'text')
      #return true

