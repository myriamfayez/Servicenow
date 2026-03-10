var app = angular.module("myapp");

app.controller(
  "homeController",
  function ($scope, productService, storeService) {
    $scope.heroBg =
      "https://images.unsplash.com/photo-1555633514-abcee6ab92e1?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    $scope.featured = [];
    $scope.loading = true;
    $scope.cart = storeService.getCart();
    $scope.favorites = storeService.getFavorites();

    $scope.loadFeatured = async function () {
      const { data, error } = await productService.getProducts();

      if (error) {
        console.log(error);
        $scope.loading = false;
        return;
      }

      $scope.featured = data.slice(0, 8);
      $scope.loading = false;

      $scope.featured.forEach(function (p) {
        if ($scope.favorites[p.id]) {
          p.liked = true;
        }
      });

      $scope.$apply();
    };

    $scope.loadFeatured();

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
