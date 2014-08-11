RailsBuilderControllers.controller('StatisticsController', ['$scope', '$http', function($scope, $http) {

  $http.get('statistics.json').success(function(data) {
    $scope.stats = data;
  });

}]);
