RailsBuilderControllers.controller('RoutesController', ['$scope', '$http', function($scope, $http) {

  $http.get('routes.json').success(function(data) {

    var controllers = {};

    for(var i=0, len=data.length; i < len; i++) {
      if (!controllers[data[i].controller]) {
        controllers[data[i].controller] = [];
      }

      controllers[data[i].controller].push(data[i]);
    }

    $scope.routes = controllers;
  });

}]);
