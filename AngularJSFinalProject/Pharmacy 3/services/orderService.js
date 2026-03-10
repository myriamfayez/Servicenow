var app = angular.module("myapp");

app.service("orderService", function () {
  this.createOrder = async function (order) {
    const { data, error } = await supabaseClient
      .from("orders")
      .insert([order])
      .select();

    return { data, error };
  };

  this.getOrders = async function () {
    const { data, error } = await supabaseClient
      .from("orders")
      .select("*")
      .order("created_at", { ascending: false });

    return { data, error };
  };

  this.getOrdersByEmail = async function (email) {
    const { data, error } = await supabaseClient
      .from("orders")
      .select("*")
      .eq("user_email", email)
      .order("created_at", { ascending: false });

    return { data, error };
  };

  this.updateOrderStatus = async function (id, status) {
    const { data, error } = await supabaseClient
      .from("orders")
      .update({ status: status })
      .eq("id", id)
      .select();

    return { data, error };
  };
});
