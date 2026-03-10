var app = angular.module("myapp");

app.controller("favoritesController", function($scope, storeService){

$scope.cart = storeService.getCart();

$scope.favorites = Object.values(storeService.getFavorites());

$scope.addToCart = function(product){
storeService.addToCart(product);
}

$scope.increaseQty = function(product){
storeService.increaseQty(product);
}

$scope.decreaseQty = function(product){
storeService.decreaseQty(product);
}

$scope.removeFavorite = function(product){

storeService.removeFavorite(product);

$scope.favorites = Object.values(storeService.getFavorites());

}

});