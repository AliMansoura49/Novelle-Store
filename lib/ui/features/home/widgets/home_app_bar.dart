
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/home/widgets/top_section.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Icon(
          Icons.store_mall_directory,
          color : Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        title: Text(
          "Novelle",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: (){
              context.push(Routes.favorite);
            },
            icon: Icon(Icons.favorite_border_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Selector<CartViewModel,int>(
                selector: (context,vm)=> vm.numberOfItemsInCart(),
                builder: (context, value, child){
                  return InkWell(
                    onTap: (){
                      context.push(Routes.cart);
                    },
                    child: badges.Badge(
                      position: badges.BadgePosition.topEnd(),
                      badgeContent: value>0 ?Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ): null,
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                  );
                }
            ),
          )
          ,
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HomeTopSection(),
          ),
        ),
      );
  }
}