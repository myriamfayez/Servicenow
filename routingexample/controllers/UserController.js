

app.controller("UserController", function($scope, UserService){

    UserService.getUsers()
        .then(function(response){
            $scope.users = response.data;
        })
        .catch(function(error){
            console.log(error);
        });

});