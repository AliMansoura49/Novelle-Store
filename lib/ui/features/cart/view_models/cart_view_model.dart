
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/ui/model/CartItem.dart';

class CartViewModel extends ChangeNotifier{

  final List<CartItem> _addedToCartProducts = [];
  List<CartItem> get addedToCartProducts => _addedToCartProducts;



  int numberOfItemsInCart() => _addedToCartProducts.length;
  
  double calculateSubtotal(){
    double subtotal = 0.0;
    for(var cartItem in _addedToCartProducts){
      final product = cartItem.product;
      final priceAfterDiscount = product.price * (100 - product.discountPercentage) / 100;
      subtotal += priceAfterDiscount * cartItem.quantity;
    }
    return subtotal;
  }

  addToCart(Product product){
    _addedToCartProducts.add(
        CartItem(product: product, quantity: 1)
    );
    notifyListeners();
  }

  removeFromCart(int index){
    final cartItem = addedToCartProducts[index];
    _addedToCartProducts.remove(cartItem);
    log(" Removed from cart",name:"CartViewModel");
    notifyListeners();
  }

  increaseQuantity(int index){
    final cartItem = _addedToCartProducts[index];
    if(canIncreaseQuantity(index)){
      cartItem.quantity++;
      notifyListeners();
    }
  }

  decreaseQuantity(int index){
    final cartItem = _addedToCartProducts[index];
      if(cartItem.quantity == 1) {
        removeFromCart(index);
      } else {
        cartItem.quantity--;
        notifyListeners();
      }
  }

  bool canIncreaseQuantity(int index){
    final cartItem = addedToCartProducts[index];
    return cartItem.product.stock > cartItem.quantity;
  }


  bool isAddedToCart(int id){
    return _addedToCartProducts.any((p)=>p.product.id == id);
  }
}