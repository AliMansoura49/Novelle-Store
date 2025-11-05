import 'package:store/domain/models/product/product.dart';

import 'package:store/utils/result.dart';

import '../../services/api/product_api_service.dart';
import '../../../domain/repositories/ProductsRepository.dart';
import '../../../data/services/api/network_constants.dart';

class ProductRepositoryRemote implements ProductRepository{

  ProductRepositoryRemote({
    required ProductApiService productApiService
    }): _productApi = productApiService;

  final ProductApiService _productApi;


  @override
  Future<Result<List<Product>>> getAllProducts({required int page}) async{
    return _productApi.getAllProducts(limit: NetworkConstants.pageSize, skip: (page-1) * NetworkConstants.pageSize);
  }

  @override
  Future<Result<Product>> getProductById(int id) async {
    return _productApi.getProductById(id);
  }

  @override
  Future<Result<List<Product>>> getProductsByCategory(String category) async {
    return _productApi.getProductsByCategory(category);
  }
  @override
  Future<Result<List<String>>> getCategoryList() async {
    return _productApi.getCategoryList();
  }

}