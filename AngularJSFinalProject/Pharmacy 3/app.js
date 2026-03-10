var app = angular.module("myapp", ["ngRoute"]);

app.config(function ($routeProvider) {
  $routeProvider

    .when("/home", {
      templateUrl: "views/home.html",
      controller: "homeController",
    })

    .when("/login", {
      templateUrl: "views/login.html",
      controller: "loginController",
    })

    .when("/register", {
      templateUrl: "views/register.html",
      controller: "registerController",
    })

    .when("/beauty", {
      templateUrl: "views/beauty.html",
      controller: "beautyController",
    })

    .when("/medication", {
      templateUrl: "views/medication.html",
      controller: "medicationController",
    })

    .when("/allproducts", {
      templateUrl: "views/allproducts.html",
      controller: "allProductsController",
    })

    .when("/vitamins", {
      templateUrl: "views/vitamins.html",
      controller: "vitaminsController",
    })

    .when("/cart", {
      templateUrl: "views/cart.html",
      controller: "cartController",
    })

    .when("/checkout", {
      templateUrl: "views/checkout.html",
      controller: "checkoutController",
    })

    .when("/invoice", {
      templateUrl: "views/invoice.html",
      controller: "invoiceController",
    })

    .when("/favorites", {
      templateUrl: "views/favorites.html",
      controller: "favoritesController",
    })

    .when("/profile", {
      templateUrl: "views/profile.html",
      controller: "profileController",
    })

    .when("/product/:id", {
      templateUrl: "views/productdetail.html",
      controller: "productDetailController",
    })

    .when("/beautydashboard", {
      templateUrl: "views/beautydashboard.html",
      controller: "beautyDashboardController",
    })

    .when("/inventory", {
      templateUrl: "views/inventory.html",
      controller: "inventoryController",
    })

    .when("/orders", {
      templateUrl: "views/orders.html",
      controller: "ordersController",
    })

    .when("/productform", {
      templateUrl: "views/productform.html",
      controller: "productFormController",
    })

    .when("/about", {
      templateUrl: "views/about.html",
    })

    .when("/contact", {
      templateUrl: "views/contact.html",
    })

    .otherwise({
      redirectTo: "/home",
    });
});

app.run(function ($rootScope, $location, storeService) {
  $rootScope.isLoggedIn = sessionStorage.getItem("isLoggedIn") === "true";
  $rootScope.isAdmin = sessionStorage.getItem("role") === "admin";
  $rootScope.username = sessionStorage.getItem("username");

  $rootScope.parseNum = function (val) {
    if (typeof val === "string") {
      val = val.replace(/,/g, "");
    }
    return parseFloat(val) || 0;
  };

  $rootScope.getCartCount = function () {
    return Object.keys(storeService.getCart() || {}).length;
  };

  $rootScope.getFavoritesCount = function () {
    return Object.keys(storeService.getFavorites() || {}).length;
  };

  $rootScope.logout = function () {
    sessionStorage.clear();

    $rootScope.isLoggedIn = false;
    $rootScope.isAdmin = false;
    $rootScope.username = "";

    $location.path("/home");
  };
});

app.directive("imgFallback", function () {
  return {
    restrict: "A",
    link: function (scope, element) {
      element.on("error", function () {
        element.attr(
          "src",
          "https://placehold.co/200x200/e8f5e9/198754?text=Pharmacy",
        );
      });
    },
  };
});
