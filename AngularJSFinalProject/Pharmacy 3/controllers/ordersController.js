var app = angular.module("myapp");

app.controller("ordersController", function ($scope, $timeout, orderService) {
  $scope.orders = [];

  $scope.loadOrders = async function () {
    const { data, error } = await orderService.getOrders();

    if (error) {
      console.log(error);
      return;
    }

    $scope.orders = data || [];
    $scope.$apply();
  };

  $scope.loadOrders();

  $scope.updateStatus = async function (order, newStatus) {
    await orderService.updateOrderStatus(order.id, newStatus);

    order.status = newStatus;

    $timeout(function () {
      $scope.$apply();
    });
  };
});
