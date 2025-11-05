import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/model/CartItem.dart';

import '../../../../routing/routes.dart';
import '../../../core/ui/cards/cart_item_card.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final _key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CartViewModel>();
    return AnimatedList(
      padding: EdgeInsets.all(4),
      shrinkWrap: true,
        key: _key,
        initialItemCount: viewModel.numberOfItemsInCart(),
        itemBuilder:  (context, index,animation){
          final cartItem = viewModel.addedToCartProducts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildAnimatedItem(context, index, animation,cartItem, viewModel),
          );
        },
    );
  }

  Widget _buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
    CartItem cartItem,
    CartViewModel viewModel,
  ) {
    final product = cartItem.product;
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
          opacity: animation,
        child: CartItemCard(
          key: ValueKey(product.id),
          onTap: (){
            context.push(Routes.getProductDetailsWithId(product.id));
          },
          price: product.price*(100-product.discountPercentage)/100,
          width: product.dimensions.width,
          height: product.dimensions.height,
          weight: product.weight,
          title: product.title,
          imageUrl: product.thumbnail,
          quantity: cartItem.quantity,
          depth: product.dimensions.depth,
          onDecrease: (){
            viewModel.decreaseQuantity(index);
          },
          onIncrease: (){
            viewModel.increaseQuantity(index);
          },
          onDelete: (){
            _key.currentState!.removeItem(
                index, (context, animation) => _buildAnimatedItem(context, index, animation,cartItem, viewModel),
                duration: const Duration(milliseconds: 500)
            );
            viewModel.removeFromCart(index);
          },
        ),
      ),
    );
  }
}
