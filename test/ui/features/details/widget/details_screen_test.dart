

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/cards/product_details_card.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/details/view_models/details_view_model.dart';
import 'package:store/ui/features/details/widgets/details_screen.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';
import 'package:store/utils/result.dart';

import '../../../../mocks/fack_command1.dart';
import '../../../../mocks/mocks.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockDetailsViewModel mockDetailsViewModel;
  late MockCartViewModel mockCartViewModel;
  late MockFavoriteViewModel mockFavoriteViewModel;

  Widget createTestWidget() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<DetailsViewModel>.value(value: mockDetailsViewModel),
      ChangeNotifierProvider<CartViewModel>.value(value: mockCartViewModel),
      ChangeNotifierProvider<FavoriteViewModel>.value(value: mockFavoriteViewModel),
    ],
    child: const MaterialApp(
      home: DetailsScreen(),
    ),
  );
}

  
  setUp(() {
    mockDetailsViewModel = MockDetailsViewModel();
    mockCartViewModel = MockCartViewModel();
    mockFavoriteViewModel = MockFavoriteViewModel();
  });



  testWidgets('should show circular progress indicator when loading data', (tester) async{
    
    when(mockDetailsViewModel.loadProductByIdCommand)
      .thenReturn(FakeCommand1(isRunning: true));
    when(mockDetailsViewModel.product).thenReturn(null);

    await tester.pumpWidget(createTestWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
  });

  testWidgets('should show error text when loadProductByIdCommand.error is true', (tester)async{
  when(mockDetailsViewModel.loadProductByIdCommand)
      .thenReturn(FakeCommand1(hasError: true,isCompleted: true));
    when(mockDetailsViewModel.product).thenReturn(null);
    
    await tester.pumpWidget(createTestWidget());

    expect(find.text('An error occurred while loading product details.'), findsOneWidget);
  });

  testWidgets('should show product details and call addToCart when button pressed', (tester)async{
      when(mockDetailsViewModel.loadProductByIdCommand)
        .thenReturn(FakeCommand1(isCompleted: true,result: Result.ok(mockProduct)));
      when(mockDetailsViewModel.product).thenReturn(mockProduct);

      when(mockDetailsViewModel.id).thenReturn(1);

      when(mockFavoriteViewModel.isFavorite(1)).thenReturn(false);

      await tester.pumpWidget(createTestWidget());
      expect(find.byType(ProductDetailsCard), findsOneWidget);

      final addToCartButton = find.widgetWithText(ElevatedButton, 'Add to Cart');
      expect(addToCartButton, findsOneWidget);

      await tester.tap(addToCartButton);
      verify(mockCartViewModel.addToCart(mockProduct)).called(1);
  });
  
}