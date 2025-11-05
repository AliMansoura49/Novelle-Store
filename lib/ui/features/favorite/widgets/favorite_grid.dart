import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../routing/routes.dart';
import '../../../core/ui/cards/favorite_card.dart';
import '../view_models/favorite_view_model.dart';

class FavoriteGrid extends StatelessWidget {
  const FavoriteGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<FavoriteViewModel>();

    return GridView.builder(
      itemCount: viewModel.favorites.length,
      itemBuilder: (context,index){
        final product = viewModel.favorites[index];
        return FavoriteCard(
            product: product,
            onToggleFavorite: (p){
              viewModel.toggleFavorite(p);
            },
            onTap: (id){
              context.push(Routes.getProductDetailsWithId(id));
            }
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7
      ),
    );
  }
}
