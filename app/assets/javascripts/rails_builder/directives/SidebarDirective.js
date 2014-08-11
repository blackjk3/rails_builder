RailsBuilder.directive('sidebar', function() {
  return {
    restrict: 'E',
    tranclude: true,
    scope: {},
    controller: function() {},
    templateUrl: asset_url + 'templates/sidebar.html'
  }
})
