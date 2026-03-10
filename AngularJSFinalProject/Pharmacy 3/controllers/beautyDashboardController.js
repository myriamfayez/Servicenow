var app = angular.module("myapp");

app.controller(
  "beautyDashboardController",
  function ($scope, $location, productService) {
    $scope.products = [];
    $scope.paginatedProducts = [];
    $scope.loading = true;

    $scope.currentPage = 1;
    $scope.itemsPerPage = 10;
    $scope.totalPages = 1;
    $scope.pageNumbers = [];
    $scope.selectedIds = {};
    $scope.selectAll = false;

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

      $scope.updateSelectAllStatus();
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
      $scope.loading = true;
      const { data, error } = await productService.getProducts();

      if (error) {
        console.log(error);
        $scope.loading = false;
        return;
      }

      $scope.products = data;
      $scope.loading = false;

      $scope.selectedIds = {};
      $scope.selectAll = false;

      $scope.paginate();
      $scope.$apply();
    };

    $scope.loadProducts();

    $scope.toggleSelectAll = function () {
      $scope.paginatedProducts.forEach(function (p) {
        $scope.selectedIds[p.id] = $scope.selectAll;
      });
    };

    $scope.toggleProductSelection = function () {
      $scope.updateSelectAllStatus();
    };

    $scope.updateSelectAllStatus = function () {
      if ($scope.paginatedProducts.length === 0) {
        $scope.selectAll = false;
        return;
      }
      $scope.selectAll = $scope.paginatedProducts.every(function (p) {
        return $scope.selectedIds[p.id];
      });
    };

    $scope.hasSelected = function () {
      return Object.values($scope.selectedIds).some(Boolean);
    };

    $scope.goToAdd = function () {
      sessionStorage.removeItem("editProduct");
      $location.path("/productform");
    };

    $scope.goToEdit = function (product) {
      sessionStorage.setItem("editProduct", JSON.stringify(product));
      $location.path("/productform");
    };

    $scope.deleteProduct = async function (id) {
      if (
        !confirm(
          "Are you sure you want to delete this product? This cannot be undone.",
        )
      ) {
        return;
      }

      console.log("deleting product...", id);

      const { error } = await productService.deleteProduct(id);

      if (error) {
        console.log(error);
        alert("Error deleting product: " + error.message);
        return;
      }

      $scope.loadProducts();
    };

    $scope.deleteSelected = async function () {
      var idsToDelete = Object.keys($scope.selectedIds).filter(function (id) {
        return $scope.selectedIds[id];
      });

      if (idsToDelete.length === 0) return;

      if (
        !confirm(
          "Are you sure you want to delete " +
            idsToDelete.length +
            " products? This cannot be undone.",
        )
      ) {
        return;
      }

      console.log("deleting products...", idsToDelete);

      const { error } =
        await productService.deleteMultipleProducts(idsToDelete);

      if (error) {
        console.log(error);
        alert("Error deleting products: " + error.message);
        return;
      }

      $scope.loadProducts();
    };
  },
);
