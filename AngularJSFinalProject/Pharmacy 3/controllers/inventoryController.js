var app = angular.module("myapp");

app.controller("inventoryController", function ($scope, productService) {
  $scope.products = [];
  $scope.lowStock = 5;

  $scope.loadProducts = async function () {
    const { data, error } = await productService.getProducts();

    if (error) {
      console.log(error);
      return;
    }

    $scope.products = data;
    $scope.$apply();
  };

  $scope.loadProducts();

  $scope.updateStock = async function (product) {
    await productService.updateStock(product.id, product.stock);

    alert("Stock updated for " + product.name);
  };
});
