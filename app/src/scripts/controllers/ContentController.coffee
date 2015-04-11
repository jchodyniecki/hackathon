class Content extends Controller
  constructor: ($scope) ->
    $scope.setPage = (pageNo) ->
      $scope.currentPage = pageNo
    $scope.checkModel = false
    $scope.checkModelStatus = do ->
      if $scope.checkModel == false
        return "Off"
      else
        return "On"

    $scope.sample = "Hello"
    $scope.maxSize = 5
    $scope.currentPage


