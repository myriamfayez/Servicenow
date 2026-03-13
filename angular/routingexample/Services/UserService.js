

app.service("UserService", function($http){

    const API_URL = "https://spnuxpfrtluagbirquiv.supabase.co/rest/v1/users";

    const config = {
        headers: {
        "apikey": "sb_publishable_iBx7OvsnV3GiQw4FKLhWKA_p4QpRnKo",
            "Authorization": "Bearer sb_publishable_iBx7OvsnV3GiQw4FKLhWKA_p4QpRnKo",
            "Content-Type": "application/json"
        }
    };

    this.getUsers = function(){
        return $http.get(API_URL, config);
    };

    this.getUserById = function(id){
        return $http.get(API_URL + "?id=eq." + id, config);
    };

});