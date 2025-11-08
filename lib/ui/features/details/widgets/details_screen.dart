import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/cards/product_details_card.dart';
import 'package:store/ui/features/details/view_models/details_view_model.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailsViewModel viewModel = context.read<DetailsViewModel>();
    final cartViewModel = context.read<CartViewModel>();
    final favoriteViewModel = context.read<FavoriteViewModel>();
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel.loadProductByIdCommand,
          builder: (context, child) {
            if (viewModel.loadProductByIdCommand.running) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.loadProductByIdCommand.error) {
              return Center(
                child: Text("An error occurred while loading product details."),
              );
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, child) {
              if (viewModel.product == null) {
                return SizedBox();
              }
              return Column(
                children: [
                  ProductDetailsCard(
                    product: viewModel.product!,
                    isFavorite: context.select<FavoriteViewModel, bool>((vm) => vm.isFavorite(viewModel.id)),
                    onToggleFavorite: (id) {
                      favoriteViewModel.toggleFavorite(viewModel.product!);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cartViewModel.addToCart(viewModel.product!);
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
