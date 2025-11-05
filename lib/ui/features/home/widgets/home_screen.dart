
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';
import 'package:store/ui/features/home/widgets/home_app_bar.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';

import '../../../core/ui/cards/productItemCard.dart';
import '../../../model/ProductItemData.dart';
import '../view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.read<CartViewModel>();
    final favoriteViewModel = context.read<FavoriteViewModel>();

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(120), child: HomeAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagingListener<int,Product>(
          controller: context.select<HomeViewModel,PagingController<int,Product>>((vm)=>vm.pagingController),
          builder:(context,state , fetchNextPage) =>
              PagedGridView<int,Product>(
                showNewPageProgressIndicatorAsGridChild: true,
                state: state,
                fetchNextPage: fetchNextPage,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.55,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
              ),
                builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (BuildContext context, Product item, int index) {
                      final bool isFavorite = context.watch<FavoriteViewModel>().isFavorite(item.id);
                      final isAddedToCart = context.watch<CartViewModel>().isAddedToCart(item.id);
                    return  ProductItemCard(
                          isFavorite: isFavorite,
                          isAddedToCart: isAddedToCart,
                          productItemData: ProductItemData(
                            id: item.id,
                            name: item.title,
                            description: item.description,
                            brand: item.brand??"no brand",
                            imageUrl: item.thumbnail,
                            price: item.price,
                            rating: item.rating,
                          ),
                        onFavoritePressed: (i) {
                          favoriteViewModel.toggleFavorite(item);
                        },
                        onProductPressed: (id) async{
                          context.push(Routes.getProductDetailsWithId(id));
                        },
                        onAddToCartPressed: (i) {
                          cartViewModel.addToCart(item);
                        }
                      );
                },
                  firstPageProgressIndicatorBuilder: (_)=>
                    const Center(child: CircularProgressIndicator()),
                  newPageProgressIndicatorBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (context) => const Center(
                    child: Text("Error was founded"),
                  ),
                  noItemsFoundIndicatorBuilder: (_) => const Center(
                    child: Text("No items found"),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}