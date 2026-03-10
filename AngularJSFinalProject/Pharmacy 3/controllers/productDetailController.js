var app = angular.module("myapp");

app.controller(
  "productDetailController",
  function ($scope, $routeParams, productService, storeService) {
    $scope.product = {};
    $scope.cart = storeService.getCart();

    $scope.loadProduct = async function () {
      const id = $routeParams.id;

      const { data, error } = await productService.getProductById(id);

      if (error) {
        console.log(error);
        return;
      }

      $scope.product = data;

      $scope.loadRelatedProducts(data.category, data.id);

      $scope.$apply();
    };

    $scope.relatedProducts = [];
    $scope.loadingRelated = true;

    $scope.loadRelatedProducts = async function (category, currentId) {
      const { data, error } =
        await productService.getProductsByCategory(category);
      if (error) {
        console.log(error);
        $scope.loadingRelated = false;
        $scope.$apply();
        return;
      }

      $scope.relatedProducts = data
        .filter((p) => p.id !== currentId)
        .slice(0, 10);
      $scope.loadingRelated = false;
      $scope.$apply();
    };

    $scope.loadProduct();

    $scope.addToCart = function (product) {
      storeService.addToCart(product);
    };

    $scope.increaseQty = function (product) {
      storeService.increaseQty(product);
    };

    $scope.decreaseQty = function (product) {
      storeService.decreaseQty(product);
    };

    $scope.toggleFavorite = function (product) {
      storeService.toggleFavorite(product);
    };
  },
);
