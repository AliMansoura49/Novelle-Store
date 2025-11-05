import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:store/data/repositories/products/product_repository_remote.dart';
import 'package:store/data/services/api/network_constants.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/domain/repositories/ProductsRepository.dart';
import 'package:store/utils/result.dart';

import '../../mocks/mocks.mocks.dart';

void main(){
  provideDummy<Result<List<Product>>>(Result.ok(<Product>[]));

  late MockProductApiService mockApiService;
  late ProductRepository repository;

  group("ProductRepositoryRemote", (){
    setUp((){
      mockApiService = MockProductApiService();
      repository = ProductRepositoryRemote(productApiService: mockApiService);
    });
    
    test('should delegate getAllProducts to ProductApiService with correct params', ()async{
      final expected = Result.ok(<Product>[]);
      const page = 2;


      when(mockApiService.getAllProducts(limit: anyNamed("limit"),skip: anyNamed("skip"))).thenAnswer((_) async => expected);


      final result = await repository.getAllProducts(page: page);
      final ok = result as Ok<List<Product>>;
      expect(ok.value, (expected as Ok).value);

      verify(mockApiService.getAllProducts(
        limit: NetworkConstants.pageSize,
        skip: (page - 1) * NetworkConstants.pageSize,
      )).called(1);

    });



  });
}