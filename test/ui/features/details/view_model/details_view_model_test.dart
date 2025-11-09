
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/ui/features/details/view_models/details_view_model.dart';
import 'package:store/utils/result.dart';
import '../../../../mocks/mocks.dart';
import '../../../../mocks/mocks.mocks.dart';

void main(){
  late MockProductRepositoryRemote repo;
  late DetailsViewModel sut;
  provideDummy(Result<Product>.ok(mockProduct));

  setUp(() {
    repo = MockProductRepositoryRemote();
  });

  group("getProductById", (){

    test('should return a product when calling it with success result', ()async{
      when(repo.getProductById(any))
          .thenAnswer((_)async => Result.ok(mockProduct));
      sut = DetailsViewModel(repo: repo,id: 1);
      int listenerCounter = 0;
      sut.addListener((){
        listenerCounter++;
      });

      await sut.loadProductByIdCommand.execute(1);

      expect(sut.loadProductByIdCommand.result, isA<Ok<Product>>());
      expect(sut.product, mockProduct);
      expect(listenerCounter, 1);
    });

    test('should handle error when repo returns error result', ()async{
      when(repo.getProductById(any))
          .thenAnswer((_)async => Result.error(Exception("network error")));
      sut = DetailsViewModel(repo: repo,id: 1);
      int listenerCounter = 0;
      sut.addListener((){
        listenerCounter++;
      });

      await sut.loadProductByIdCommand.execute(1);

      expect(sut.loadProductByIdCommand.error, true);
      expect(sut.loadProductByIdCommand.result, isA<Error<Product>>());
      expect(sut.product, null);
      expect(listenerCounter, 1);

    });

  });
}