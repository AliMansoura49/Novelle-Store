import 'package:store/domain/models/product/product.dart';
import '../../utils/result.dart';

abstract class ProductRepository{
  Future <Result<List<Product>>> getAllProducts({required int page});
  Future<Result<Product>> getProductById(int id);
  Future<Result<List<Product>>> getProductsByCategory(String category);
  Future<Result<List<String>>> getCategoryList();
}