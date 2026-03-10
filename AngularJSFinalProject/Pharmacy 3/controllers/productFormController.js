var app = angular.module("myapp");

app.controller(
  "productFormController",
  function ($scope, $location, $timeout, productService) {
    $scope.product = {};
    $scope.isSaving = false;

    let editProduct = sessionStorage.getItem("editProduct");

    if (editProduct) {
      $scope.product = JSON.parse(editProduct);
      $scope.product.price = parseFloat($scope.product.price);
      $scope.product.stock = parseInt($scope.product.stock);
    }

    $scope.saveProduct = async function (isValid) {
      if (!isValid) {
        return;
      }

      $scope.isSaving = true;

      if ($scope.product.id) {
        await productService.updateProduct($scope.product);
      } else {
        await productService.addProduct($scope.product);
      }

      sessionStorage.removeItem("editProduct");

      const toastEl = document.getElementById("successToast");
      const toast = new bootstrap.Toast(toastEl);
      toast.show();

      $timeout(function () {
        $scope.isSaving = false;
        $location.path("/beautydashboard");
      }, 1500);
    };

    $scope.cancel = function () {
      sessionStorage.removeItem("editProduct");
      $location.path("/beautydashboard");
    };
  },
);
