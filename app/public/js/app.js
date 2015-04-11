(function() {
  var app;

  app = angular.module("app", ['ngRoute', 'ui.bootstrap']);

  app.config(function($routeProvider) {
    return $routeProvider.when('/content', {
      templateUrl: 'views/content.html',
      controller: 'contentController'
    }).otherwise({
      redirectTo: '/content'
    });
  });

}).call(this);
