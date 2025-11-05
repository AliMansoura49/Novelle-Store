import 'dart:io';
import 'package:store/domain/models/product/product.dart';
import '../../../utils/result.dart';
import 'package:dio/dio.dart';
import 'network_constants.dart';
import 'dart:developer';

class ProductApiService{
  final Dio dio;

  ProductApiService({Dio? dio}) : dio = dio?? Dio();

  Future<Result<List<Product>>> getAllProducts({required limit,required skip}) async {
    try {
      final response = await dio.get(
        NetworkConstants.productEndPoint,
        queryParameters: {'limit':limit,'skip':skip}
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];

        log("Success response ,data is $data", name: "ProductApiService");

        return Result.ok(data.map((e) => Product.fromJson(e)).toList());
      } else {
        log("Error response ,response is $response", name: "ProductApiService");
        return const Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (e) {
      log("Exception, $e", name: "ProductApiService");
      return Result.error(e);
    }
  }
  Future<Result<Product>> getProductById(int id) async{
    try {
      final response = await dio.get("${NetworkConstants.productEndPoint}/$id");
      if(response.statusCode == 200){
        final data = response.data;
        log("Success response ,data is $data", name: "ProductApiService");
        return Result.ok(Product.fromJson(data));
      }else{
        log("Error response ,response is $response", name: "ProductApiService");
        return const Result.error(HttpException("Invalid response"));
      }
    }on Exception catch(e){
      log("Exception, $e", name: "ProductApiService");
      return Result.error(e);
    }
  }

  Future<Result<List<Product>>> getProductsByCategory(String category) async{
    try {
      final url = "${NetworkConstants.categoryEndPoint}/$category";
      final response = await dio.get(url);
      log("Doing Api Call url $url ", name: "ProductApiService");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        log("Success response ,number of items ${data.length}", name: "ProductApiService");
        return Result.ok(data.map((e) => Product.fromJson(e)).toList());
      } else {
        log("Error response ,response is $response", name: "ProductApiService");
        return const Result.error(HttpException("Invalid response"));
      }
    } on Exception catch(e){
      log("Exception, $e", name: "ProductApiService");
      return Result.error(e);
    }
  }

  Future<Result<List<String>>> getCategoryList() async{
    try{
      final response = await dio.get(NetworkConstants.categoryList);
      if(response.statusCode == 200){
        final data = response.data;
        if (data is List) {
          final list = data.map((e) => e.toString()).toList();
          return Result.ok(list);
        } else {
          throw Exception("Unexpected response format: not a List");
        }
      }else{
        return const Result.error(HttpException("Invalid response"));
      }
    }on Exception catch(e){
      return Result.error(e);
    }
  }
}