app = angular.module("app", ['ngRoute', 'ui.bootstrap'])

app.config ($routeProvider) ->
  $routeProvider.
    when('/content',
      templateUrl: 'views/content.html',
      controller: 'contentController'
    ).otherwise(
      redirectTo: '/content'
    )
