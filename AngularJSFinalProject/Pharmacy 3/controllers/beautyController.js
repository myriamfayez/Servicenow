var app = angular.module("myapp");

app.controller(
  "beautyController",
  function ($scope, productService, storeService) {
    $scope.products = [];
    $scope.paginatedProducts = [];
    $scope.lowStock = 5;
    $scope.loading = true;

    $scope.currentPage = 1;
    $scope.itemsPerPage = 25;
    $scope.totalPages = 1;
    $scope.pageNumbers = [];

    $scope.cart = storeService.getCart();
    $scope.favorites = storeService.getFavorites();

    $scope.paginate = function () {
      var start = ($scope.currentPage - 1) * $scope.itemsPerPage;
      var end = start + $scope.itemsPerPage;
      $scope.paginatedProducts = $scope.products.slice(start, end);
      $scope.totalPages = Math.ceil(
        $scope.products.length / $scope.itemsPerPage,
      );
      $scope.pageNumbers = [];
      for (var i = 1; i <= $scope.totalPages; i++) {
        $scope.pageNumbers.push(i);
      }
    };

    $scope.goToPage = function (page) {
      $scope.currentPage = page;
      $scope.paginate();
      window.scrollTo(0, 0);
    };

    $scope.nextPage = function () {
      if ($scope.currentPage < $scope.totalPages) {
        $scope.currentPage++;
        $scope.paginate();
        window.scrollTo(0, 0);
      }
    };

    $scope.prevPage = function () {
      if ($scope.currentPage > 1) {
        $scope.currentPage--;
        $scope.paginate();
        window.scrollTo(0, 0);
      }
    };

    $scope.loadProducts = async function () {
      const { data, error } =
        await productService.getProductsByCategory("beauty");

      if (error) {
        console.log(error);
        $scope.loading = false;
        return;
      }

      $scope.products = data;
      $scope.loading = false;

      $scope.products.forEach(function (p) {
        if ($scope.favorites[p.id]) {
          p.liked = true;
        }
      });

      $scope.paginate();
      $scope.$apply();
    };

    $scope.loadProducts();

    $scope.toggleFavorite = function (product) {
      storeService.toggleFavorite(product);
    };

    $scope.addToCart = function (product) {
      storeService.addToCart(product);
    };

    $scope.increaseQty = function (product) {
      storeService.increaseQty(product);
    };

    $scope.decreaseQty = function (product) {
      storeService.decreaseQty(product);
    };
  },
);
