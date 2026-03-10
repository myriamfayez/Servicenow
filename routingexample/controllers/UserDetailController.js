app.controller("UserDetailController", function($scope, $routeParams, UserService){

    var userId = $routeParams.id;

    UserService.getUserById(userId)
        .then(function(response){
            $scope.user = response.data[0]; 
        })
        .catch(function(error){
            console.log(error);
        });

});