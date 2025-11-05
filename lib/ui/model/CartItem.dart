import 'package:store/domain/models/product/product.dart';

class CartItem{
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity
  });

}