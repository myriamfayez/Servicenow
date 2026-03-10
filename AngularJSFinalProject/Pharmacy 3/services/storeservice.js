var app = angular.module("myapp");

app.service("storeService", function () {
  var cart = JSON.parse(localStorage.getItem("cart")) || {};
  var favorites = {};

  function saveCart() {
    localStorage.setItem("cart", JSON.stringify(cart));
  }

  this.getCart = function () {
    return cart;
  };

  this.getFavorites = function () {
    return favorites;
  };

  this.addToCart = function (product) {
    if (!cart[product.id]) {
      cart[product.id] = {
        product: product,
        qty: 1,
      };
      saveCart();
    }
  };

  this.increaseQty = function (product) {
    if (cart[product.id].qty < product.stock) {
      cart[product.id].qty++;
      saveCart();
    }
  };

  this.decreaseQty = function (product) {
    if (cart[product.id].qty > 1) {
      cart[product.id].qty--;
    } else {
      delete cart[product.id];
    }
    saveCart();
  };

  this.removeFromCart = function (productId) {
    delete cart[productId];
    saveCart();
  };

  this.clearCart = function () {
    cart = {};
    localStorage.removeItem("cart");
  };

  this.getCartTotal = function () {
    var total = 0;

    Object.values(cart).forEach(function (item) {
      var priceStr = String(item.product.price).replace(/,/g, "");
      total += (parseFloat(priceStr) || 0) * item.qty;
    });

    return total;
  };

  this.toggleFavorite = function (product) {
    if (favorites[product.id]) {
      delete favorites[product.id];
      product.liked = false;
    } else {
      favorites[product.id] = product;
      product.liked = true;
    }
  };

  this.removeFavorite = function (product) {
    delete favorites[product.id];
    product.liked = false;
  };
});
