


var app = angular.module("productApp", ["ngRoute"]);

app.config(function($routeProvider){

    $routeProvider
        .when("/", {
            templateUrl: "views/users.html",
            controller: "UserController"
        })
        .when("/users/:id", {
            templateUrl: "views/userDetails.html",
            controller: "UserDetailController"
        })
        .otherwise({
            redirectTo: "/"
        });

});