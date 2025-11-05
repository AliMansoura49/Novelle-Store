import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/dialogs/loading_dialog.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/cart/widgets/cart_list.dart';
import 'package:store/ui/features/cart/widgets/cart_bottom_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.read<CartViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              context.pop();
            },
            icon: Icon(Icons.arrow_back)
        ),
        title: Text(
          "My Cart (${cartViewModel.addedToCartProducts.length})",
        ),
      ),
      bottomNavigationBar: Consumer<CartViewModel>(
        builder: (context,vm ,child)=>
        cartViewModel.addedToCartProducts.isEmpty ? SizedBox.shrink() :
        CartBottomBar(
        subtotal: cartViewModel.calculateSubtotal(), 
        onCheckout: (){
          showDialog(context: context, builder: (context)=>LoadingDialog());
        }
      ),),
      body: Consumer<CartViewModel>(
       builder: (context,vm,child)=>
       cartViewModel.addedToCartProducts.isEmpty ? Center(
        child: Text(
          "Your cart is empty",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
       ): CartList()
       )
      
    );
  }
}
