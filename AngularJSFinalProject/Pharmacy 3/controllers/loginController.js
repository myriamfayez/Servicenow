var app = angular.module("myapp");

app.controller(
  "loginController",
  function ($scope, $location, $rootScope, $timeout) {
    $scope.user = {};

    $scope.login = async function () {
      const email = $scope.user.email.trim().toLowerCase();
      const password = $scope.user.password;

      const { data, error } = await supabaseClient.auth.signInWithPassword({
        email: email,
        password: password,
      });

      if (error) {
        alert("Email or password incorrect");
        return;
      }

      const admins = ["admin@gmail.com", "admin2@gmail.com"];

      let role = "user";

      if (admins.includes(email)) {
        role = "admin";
      }

      const { data: users } = await supabaseClient.from("users").select("*");

      const profile = users.find((u) => u.email.toLowerCase() === email);

      const username = profile ? profile.username : "Admin";

      $rootScope.isLoggedIn = true;
      $rootScope.isAdmin = role === "admin";
      $rootScope.username = username;

      sessionStorage.setItem("isLoggedIn", "true");
      sessionStorage.setItem("role", role);
      sessionStorage.setItem("username", username);
      sessionStorage.setItem("email", email);

      $timeout(function () {
        $location.path("/beauty");
      });
    };
  },
);
