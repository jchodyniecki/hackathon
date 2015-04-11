(function() {
  var Content;

  Content = (function() {
    function Content($scope) {
      $scope.setPage = function(pageNo) {
        return $scope.currentPage = pageNo;
      };
      $scope.checkModel = false;
      $scope.checkModelStatus = (function() {
        if ($scope.checkModel === false) {
          return "Off";
        } else {
          return "On";
        }
      })();
      $scope.sample = "Hello";
      $scope.maxSize = 5;
      $scope.currentPage;
    }

    return Content;

  })();

  angular.module('app').controller('contentController', ['$scope', Content]);

}).call(this);
