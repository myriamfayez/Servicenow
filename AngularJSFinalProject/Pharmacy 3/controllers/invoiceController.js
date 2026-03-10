var app = angular.module("myapp");

app.controller("invoiceController", function ($scope) {
  $scope.order = JSON.parse(sessionStorage.getItem("lastOrder"));

  $scope.today = new Date();

  $scope.printInvoice = function () {
    window.print();
  };
});
