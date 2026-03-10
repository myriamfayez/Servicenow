var app = angular.module("myapp");

app.controller("cartController", function($scope, storeService){

$scope.cart = Object.values(storeService.getCart());

$scope.removeFromCart = function(product){

storeService.removeFromCart(product.id);

$scope.cart = Object.values(storeService.getCart());

};

});

