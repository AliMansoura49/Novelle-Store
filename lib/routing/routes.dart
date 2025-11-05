
abstract final class Routes{
  static const signup = "/signup";
  static const login = "/login";
  static const home = "/";
  static const productDetails = "/product_details/:id";
  static const cart = "/cart";
  static const favorite = "/favorite";
  
  static getProductDetailsWithId(int id) => "/product_details/$id";
}