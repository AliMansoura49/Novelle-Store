import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:store/data/services/api/network_constants.dart';
import 'package:store/data/services/api/product_api_service.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/utils/result.dart';

import '../../../mocks/mocks.mocks.dart';

void main(){
  group("ProductsApiService", () {
    late MockDio mockDio;
    late ProductApiService productApiService;
    final mockJson = {
      "id": 1,
      "title": "Laptop",
      "description": "High-end laptop",
      "category": "electronics",
      "price": 1500.0,
      "discountPercentage": 10.0,
      "rating": 4.8,
      "stock": 25,
      "tags": ["tech", "laptop"],
      "brand": "Lenovo",
      "warrantyInformation": "1 year warranty",
      "shippingInformation": "Ships in 3–5 days",
      "availabilityStatus": "In stock",
      "reviews": [],
      "images": ["img1.jpg"],
      "dimensions": {"width": 30.0, "height": 20.0, "depth": 2.0},
      "thumbnail": "thumb.jpg",
      "weight": 1.5
    };


    setUp(() {
      mockDio = MockDio();
      productApiService = ProductApiService(dio: mockDio);
    });

    test('should return list of products', () async {
      final response = Response(
          data: {'products': [mockJson]},
          statusCode: 200,
          requestOptions: RequestOptions(
              path: NetworkConstants.productEndPoint,
              method: "GET"
          )
      );

      when(mockDio.get(
          NetworkConstants.productEndPoint,
          queryParameters: {'limit': 10, 'skip': 0}
      )).thenAnswer((_) async {
        return response;
      });

      final result = await productApiService.getAllProducts(limit: 10, skip: 0);

      expect(result.isOk, true);
      expect((result as Ok).value, [Product.fromJson(mockJson)]);
    });

    test('getProductById should return a single product', () async {
      final id = 1;
      final response = Response(
          data: mockJson,
          statusCode: 200,
          requestOptions: RequestOptions(
              path: "${NetworkConstants.productEndPoint}/$id",
              method: "GET"
          )
      );

      when(mockDio.get("${NetworkConstants.productEndPoint}/$id"))
          .thenAnswer((_) async => response);

      final result = await productApiService.getProductById(1);

      expect(result.isOk, true);
      expect((result as Ok).value, Product.fromJson(mockJson));
    });

    test('getProductsByCategory should return a list of products', () async {
      final category = "electronics";

      final response = Response(
        data: {'products':[mockJson]},
        statusCode: 200,
        requestOptions: RequestOptions(
          path: "${NetworkConstants.categoryEndPoint}/$category",
          method: "GET",
        )
      );

      when(mockDio.get("${NetworkConstants.categoryEndPoint}/$category"))
      .thenAnswer((_)async=>response);

      final result = await productApiService.getProductsByCategory(category);

      expect(result.isOk, true);
      expect((result as Ok).value, [Product.fromJson(mockJson)]);

    });

    test('should return a list of categories when response status is 200', () async {
      final categories = ["electronics","beauty"];
      final response = Response(
        data: categories,
        requestOptions: RequestOptions(
          path: NetworkConstants.categoryList,
          method: "GET"
        ),
        statusCode: 200
      );

      when(mockDio.get(NetworkConstants.categoryList))
      .thenAnswer((_)async=>response);

      final result = await productApiService.getCategoryList();

      expect(result.isOk, true);
      expect((result as Ok).value, categories);

    });

    test("should return Exception when status code is not 200", ()async{
      final response = Response(
        data: {},
          statusCode: 404,
        requestOptions: RequestOptions(
          path: '',
        )
      );

      when(mockDio.get(any)).thenAnswer((_)async=>response);

      final result = await productApiService.getCategoryList();

      expect(result.isError, true);
      expect((result as Error).error, isA<Exception>());

    });

  });

}