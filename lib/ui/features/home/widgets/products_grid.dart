import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';

import '../../../core/ui/cards/productItemCard.dart';
import '../../../model/ProductItemData.dart';

class ProductsGrid extends StatelessWidget {

  final List<ProductItemData> products;
  final Function(int) onFavoritePressed;
  final Function(int) onProductPressed;
  final Function(int) onAddToCartPressed;

  const ProductsGrid({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductPressed,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 0.55,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        children: List.generate(products.length, (index) {
          final product = products[index];
          final isFavorite = context.watch<FavoriteViewModel>().isFavorite(product.id);
          final isAddedToCart = context.watch<CartViewModel>().isAddedToCart(product.id);

          return
              ProductItemCard(
              isFavorite: isFavorite,
              isAddedToCart: isAddedToCart,
              productItemData: ProductItemData(
                  id: product.id,
                  name: product.name,
                  description: product.description,
                  brand: product.brand,
                  imageUrl: product.imageUrl,
                  price: product.price,
                  rating: product.rating,
              ),
              onFavoritePressed: onFavoritePressed,
              onProductPressed: onProductPressed,
              onAddToCartPressed: onAddToCartPressed
          );
            }
            )
    );
  }
}
