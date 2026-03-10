var app = angular.module("myapp");

app.service("productService", function () {
  this.getProducts = async function () {
    const { data, error } = await supabaseClient.from("products").select("*");

    return { data, error };
  };

  this.getProductsByCategory = async function (category) {
    const { data, error } = await supabaseClient
      .from("products")
      .select("*")
      .eq("category", category);

    return { data, error };
  };

  this.getProductById = async function (id) {
    const { data, error } = await supabaseClient
      .from("products")
      .select("*")
      .eq("id", id)
      .single();

    return { data, error };
  };

  this.addProduct = async function (product) {
    return await supabaseClient.from("products").insert([product]);
  };

  this.deleteProduct = async function (id) {
    return await supabaseClient.from("products").delete().eq("id", id);
  };

  this.deleteMultipleProducts = async function (ids) {
    return await supabaseClient.from("products").delete().in("id", ids);
  };

  this.updateProduct = async function (product) {
    const { data, error } = await supabaseClient
      .from("products")
      .update({
        name: product.name,
        price: product.price,
        img: product.img,
        stock: product.stock,
        category: product.category,
      })
      .eq("id", product.id)
      .select();

    return { data, error };
  };

  this.updateStock = async function (id, stock) {
    const { data, error } = await supabaseClient
      .from("products")
      .update({ stock: stock })
      .eq("id", id)
      .select();

    return { data, error };
  };
});
