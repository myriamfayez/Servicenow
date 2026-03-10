var app = angular.module("myapp");

app.controller(
  "profileController",
  function ($scope, $rootScope, orderService) {
    $scope.username = $rootScope.username;
    $scope.email = sessionStorage.getItem("email") || "";
    $scope.role = sessionStorage.getItem("role") || "user";

    $scope.orders = [];

    $scope.loadOrders = async function () {
      const { data, error } = await orderService.getOrdersByEmail($scope.email);

      if (error) {
        console.log(error);
        return;
      }

      $scope.orders = data || [];
      $scope.$apply();
    };

    $scope.loadOrders();
  },
);
