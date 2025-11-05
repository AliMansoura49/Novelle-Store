
abstract class NetworkConstants {
  static const String baseUrl = 'https://dummyjson.com';
  static const int pageSize = 10;

  static const String productEndPoint = "$baseUrl/product";
  static const String categoryEndPoint = "$productEndPoint/category";
  static const String categoryList = "$productEndPoint/category-list";
}