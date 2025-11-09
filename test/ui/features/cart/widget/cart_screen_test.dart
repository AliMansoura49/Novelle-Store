
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/cards/cart_item_card.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/cart/widgets/cart_list.dart';
import 'package:store/ui/features/cart/widgets/cart_screen.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late CartViewModel cartViewModel;

  setUp(() {
    cartViewModel = CartViewModel();
  });

  _addMockProductsToCart() {
    cartViewModel.addToCart(mockProduct);
    cartViewModel.addToCart(mockProduct2);
  }


  Widget _createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider(
      create:  (_) => cartViewModel,
      child: CartScreen()
    ),
    );
  }

  group('CartList WidgetTest', (){

  testWidgets('should show empty text when there are no data', (tester)async{
    await tester.pumpWidget(_createTestWidget());
    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('should show a list of items when there are some items', (tester)async{
    _addMockProductsToCart();

    await tester.pumpWidget(_createTestWidget());
    await tester.pump();


    final cartListFinder = find.byType(CartList);
    final cartItemFinder = find.byType(CartItemCard);

    expect(cartListFinder, findsOneWidget);
    expect(cartItemFinder, findsNWidgets(2));


  });

  testWidgets('should increase the quantity when tap on increase button', (tester)async{
    _addMockProductsToCart();

    await tester.pumpWidget(_createTestWidget());
    await tester.pump();

    final firstIncreaseButtonFinder = find.byKey(const Key("increase_button")).first;

    expect(firstIncreaseButtonFinder, findsOneWidget);

    await tester.tap(firstIncreaseButtonFinder);
    await tester.pump();

    final quantityTextFinder = find.text('2');

    expect(quantityTextFinder, findsOneWidget);
  });

  testWidgets('should decrease the quantity when tap on decrease button', (tester)async{
    //add
    _addMockProductsToCart();
    cartViewModel.increaseQuantity(0); //make quantity 2

    await tester.pumpWidget(_createTestWidget());
    await tester.pump();

    final firstDecreaseButtonFinder = find.byKey(const Key("increase_button")).first;

    expect(firstDecreaseButtonFinder, findsOneWidget);

    await tester.tap(firstDecreaseButtonFinder);
    await tester.pump();

    final quantityTextFinder = find.text('1');

    expect(quantityTextFinder, findsOneWidget);
  });
  testWidgets('should remove the item when quantity become 0', (tester)async{
    //add
    _addMockProductsToCart();
    cartViewModel.decreaseQuantity(0); //make quantity 2

    await tester.pumpWidget(_createTestWidget());
    await tester.pump();

    final cartItemFinder = find.byType(CartItemCard);
    expect(cartItemFinder, findsOneWidget);
  });
  });

  testWidgets('should show the total and the subtotal', (tester)async{
    //add
    _addMockProductsToCart();

    await tester.pumpWidget(_createTestWidget());
    await tester.pump();

    final subtotalTextFinder = find.text('\$176.00'); //mockProduct + mockProduct2 prices
    final totalTextFinder = find.text('\$184.80');

    expect(subtotalTextFinder, findsOneWidget);
    expect(totalTextFinder, findsOneWidget);
  });

}