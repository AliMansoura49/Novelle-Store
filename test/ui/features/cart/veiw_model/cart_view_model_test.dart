
import 'package:flutter_test/flutter_test.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';

import '../../../../mocks/mocks.dart';

void main(){
  late CartViewModel sut;
  late int listenerCounter;
  
  setUp((){
    sut = CartViewModel();
    listenerCounter = 0;
    sut.addListener((){listenerCounter++;});
    });


  test('inital setup',(){
    expect(sut.addedToCartProducts, isEmpty);
    expect(sut.numberOfItemsInCart(),0);
  });

  test('should add a new item to cart', (){

    //act
    sut.addToCart(mockProduct);

    //assert 
    expect(listenerCounter, 1);
    expect(sut.addedToCartProducts.length, 1);
    expect(sut.addedToCartProducts[0].product, mockProduct);
    expect(sut.addedToCartProducts[0].quantity, 1);

  });

  test('should remove an item when calling remove method',(){
    //Arrange
    sut.addToCart(mockProduct);

    //Act
    sut.removeFromCart(0);

    //Assert
    expect(listenerCounter, 2);
    expect(sut.addedToCartProducts.length, 0);
    
  });

  test('should increase the quantity of an item when calling increase method',(){
    //Arrange
    sut.addToCart(mockProduct);
    //Act
    sut.increaseQuantity(0);
    //Assert
    expect(listenerCounter, 2);
    expect(sut.addedToCartProducts[0].quantity, 2);
  });
  test('should decrease the quantity of an item when calling increase method',(){
    //Arrange
    sut.addToCart(mockProduct);
    sut.increaseQuantity(0);
    //Act
    sut.decreaseQuantity(0);
    //Assert
    expect(listenerCounter, 3);
    expect(sut.addedToCartProducts[0].quantity, 1);
  });

  test('should remove the item when quatity get 0',(){
    //Arrange
    sut.addToCart(mockProduct);
    //Act
    sut.decreaseQuantity(0);
    //Assert
    expect(listenerCounter, 2);
    expect(sut.addedToCartProducts, isEmpty);
  });

  group('canIncreaseQuantity', (){
    test('should return true when we can increase', (){
      //Arrange
      sut.addToCart(mockProduct);
      //Act
      final result = sut.canIncreaseQuantity(0);
      //Assert
      expect(result, true);
    });
    
    test('should return false when we can not increase', (){
      //Arrange
      sut.addToCart(mockProduct.copyWith(stock: 1));
      //Act
      final result = sut.canIncreaseQuantity(0);
      //Assert
      expect(result, false);
    });
  });

  group('isAddedToCart', (){
    test('should return true when given an existent id', (){
      //Arrange
      sut.addToCart(mockProduct);
      //Act
      final result = sut.isAddedToCart(1);
      //Assert
      expect(result, true);
    });
    test('should return false when given a non existent id', (){
      //Arrange
      sut.addToCart(mockProduct);
      //Act
      final result = sut.isAddedToCart(2);
      //Assert
      expect(result, false);
    });
  });
  
  group('calculateSubtotal', (){
    test('should calculate subtotal for single item with discount', (){
      // Arrange: set known price and discount
      final p = mockProduct.copyWith(price: 100, discountPercentage: 10);
      sut.addToCart(p);

      // Act
      final subtotal = sut.calculateSubtotal();

      // Assert: 100 with 10% discount -> 90
      expect(subtotal, 90);
    });

    test('should calculate subtotal for multiple items and quantities', (){
      // Arrange
      final p1 = mockProduct.copyWith(price: 100, discountPercentage: 10);
      final p2 = mockProduct.copyWith(id: 2, price: 50, discountPercentage: 20);

      sut.addToCart(p1); // index 0
      sut.increaseQuantity(0); // quantity -> 2 (p1 subtotal = 180)
      sut.addToCart(p2); // index 1 (p2 price after 20% = 40)

      // Act
      final subtotal = sut.calculateSubtotal();

      // Assert: 180 + 40 = 220
      expect(subtotal, 220);
    });
  });
  
}
