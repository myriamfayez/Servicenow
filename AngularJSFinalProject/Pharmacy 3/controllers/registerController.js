var app = angular.module("myapp");

app.controller("registerController", function($scope, $location){

$scope.user = {};

$scope.register = async function(){

if($scope.user.password !== $scope.user.confirmPassword){
alert("Passwords do not match");
return;
}

const { data, error } = await supabaseClient.auth.signUp({
email: $scope.user.email.trim(),
password: $scope.user.password
});

if(error){
alert(error.message);
return;
}

const userId = data.user.id;

const { error: insertError } = await supabaseClient
.from("users")
.insert([
{
id: userId,
email: $scope.user.email,
role: "user",   
username: $scope.user.username
}
]);

if(insertError){
alert(insertError.message);
return;
}

alert("Account created successfully");


$location.path("/login");
$scope.$apply();

};

});