var RailsBuilder = angular.module('RailsBuilder', ['ngRoute', 'RailsBuilderControllers']);
var RailsBuilderControllers = angular.module('RailsBuilderControllers', []);

RailsBuilder.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when('/statistics', {
      templateUrl: asset_url + 'views/statistics.html',
      controller: 'StatisticsController'
    }).
    when('/routes', {
      templateUrl: asset_url + 'views/routes.html',
      controller: 'RoutesController'
    }).
    when('/migrations', {
      templateUrl: asset_url + 'views/migrations.html',
      controller: 'MigrationsController'
    }).
    // when('/phones/:phoneId', {
    //   templateUrl: 'partials/phone-detail.html',
    //   controller: 'PhoneDetailCtrl'
    // }).
    otherwise({
      redirectTo: '/statistics'
    });
}]);

RailsBuilder.directive('ngConfirmClick', [
  function(){
    return {
      priority: -1,
      restrict: 'A',
      link: function(scope, element, attrs){
        element.bind('click', function(e){
          var message = attrs.ngConfirmClick;
          if(message && !confirm(message)){
            e.stopImmediatePropagation();
            e.preventDefault();
          }
        });
      }
    }
  }
]);
