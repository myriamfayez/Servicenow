var app = angular.module("myapp");

app.controller(
  "checkoutController",
  function (
    $scope,
    $location,
    $rootScope,
    $timeout,
    storeService,
    orderService,
  ) {
    $scope.cart = Object.values(storeService.getCart());
    $scope.total = storeService.getCartTotal();

    if (!$rootScope.isLoggedIn) {
      $timeout(function () {
        $location.path("/login");
      });
      return;
    }

    $scope.shipping = {};

    $scope.parseNum = function (val) {
      if (typeof val === "string") {
        val = val.replace(/,/g, "");
      }
      return parseFloat(val) || 0;
    };

    $scope.placeOrder = async function () {
      if ($scope.cart.length === 0) {
        alert("Your cart is empty");
        return;
      }

      var items = $scope.cart.map(function (item) {
        return {
          name: item.product.name,
          price: item.product.price,
          qty: item.qty,
          img: item.product.img,
        };
      });

      var order = {
        user_email: sessionStorage.getItem("email") || "guest@pharmacy.com",
        username: $rootScope.username || "Guest",
        items: items,
        total: $scope.total,
        status: "completed",
      };

      const { data, error } = await orderService.createOrder(order);

      if (error) {
        alert("Error placing order: " + error.message);
        return;
      }

      storeService.clearCart();

      sessionStorage.setItem("lastOrder", JSON.stringify(data[0]));

      $timeout(function () {
        $location.path("/invoice");
      });
    };
  },
);
