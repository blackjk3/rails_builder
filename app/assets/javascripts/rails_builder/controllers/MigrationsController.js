RailsBuilderControllers.controller('MigrationsController', ['$scope', '$http', '$compile', function($scope, $http, $compile) {

  var rows = $scope.rows = [];
  var columnTypes = [
    { id: "string", name: "String" },
    { id: "text", name: "Text" },
    { id: "integer", name: "Integer" },
    { id: "float", name: "Float" },
    { id: "decimal", name: "Decimal" },
    { id: "boolean", name: "Boolean" },
    { id: "date", name: "Date" },
    { id: "time", name: "Time" },
    { id: "datetime", name: "DateTime" },
    { id: "timestamp", name: "Timestamp" }
  ];

  var fetch = function() {
    $http.get('migrations.json').success(function(data) {
      $scope.data = data;
    });
  }

  var run = function(direction, version) {
   
    if(!version) {
      bootbox.alert("There must be a version attached.");
      return;
    }
    var migrateString = "";
    migrateString = (direction === 'up' || direction === 'down') ? "migrate " + direction : direction + ' migration' ;

    bootbox.confirm("Are you sure you wish to " + migrateString + "?", function(result) {
      if(result) {
        var url = 'migrations/' + direction + '.json?version=' + version;
        $http.get( url ).success(function(data, status, headers, config) {
          if(data.success) {
            bootbox.alert("Migration Complete.", function() {
              fetch();
            });
          }
        }).
        error(function(data, status, headers, config) {
          bootbox.dialog({
            message: data,
            title: "Migration Failed",
            buttons: {
              success: {
                label: "Ok",
                className: "btn-success"
              }
            }
          });
        });
      }
    });
  }

  var bootboxCustom = function(title, message) {
    bootbox.dialog({
      message: message,
      title: title,
      buttons: {
        success: {
          label: "Ok",
          className: "btn-success"
        }
      }
    });
  }

  fetch();

  $scope.addRow = function() {
    rows.push({
			title: 'Testing',
      value: null,
			columnTypes: columnTypes
		});
  };

  $scope.removeRow = function (row) {
		rows.splice(rows.indexOf(row), 1);
	};

  $scope.createMigration = function() {

  }

  $scope.migrate = function() {
    bootbox.confirm("Are you sure you wish to migrate?", function(result) {
      if(result) {
        $http.get('migrations/migrate.json').success(function(data) {
          if(data.success) {
            bootbox.alert("Rake DB:Migrate Complete.", function() {
              fetch();
            });
          }
        }).
        error(function(data, status, headers, config) {
          bootboxCustom("Rake DB:Migrate Failed", data);
        });
      }
    });
  }

  $scope.rollback = function() {
    bootbox.confirm("Are you sure you wish to rollback?", function(result) {
      if(result) {
        $http.get('migrations/rollback.json').success(function(data) {
          if(data.success) {
            bootbox.alert("Rake DB:Rollback Complete.", function() {
              fetch();
            });
          }
        }).
        error(function(data, status, headers, config) {
          bootboxCustom("Rake DB:Rollback Failed", data);
        });
      }
    });
  }

  $scope.reload = function(version) {
    run('reload', version);
  }

  $scope.down = function(version) {
    run('down', version);
  }

  $scope.up = function(version) {
    run('up', version)
  }

}]);
