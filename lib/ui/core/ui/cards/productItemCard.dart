
import 'package:flutter/material.dart';
import 'package:store/ui/core/ui/buttons/add_to_cart_button.dart';
import 'package:store/ui/core/ui/buttons/fav_button.dart';
import 'package:store/ui/model/ProductItemData.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItemCard extends StatelessWidget {
  final ProductItemData productItemData;
  final bool isFavorite;
  final bool isAddedToCart;
  final void Function(int id) onFavoritePressed;
  final void Function(int id) onProductPressed;
  final void Function(int id) onAddToCartPressed;

  const ProductItemCard({
    super.key,
    required this.isFavorite,
    required this.isAddedToCart,
    required this.productItemData,
    required this.onFavoritePressed,
    required this.onProductPressed,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final product = productItemData;
    return InkWell(
      onTap:(){
        onProductPressed(product.id);
      },
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: isAddedToCart ? 1 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children:[
                    CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: product.imageUrl,
                        placeholder: (context, url) =>  Center(
                            child: CircularProgressIndicator()
                        ),
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                        fit: BoxFit.cover,
                      ),
                Positioned(
                        top: 0,
                        right: 0,
                        child: FavButton(
                          isFavorite: isFavorite, 
                          onClick: (){
                            onFavoritePressed(product.id);
                          }
                        )
                      )
                  ]
                ),
              ),
              SizedBox(height: 4,),
            Text(
                  product.brand,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              SizedBox(height: 4,),
              Text(
                  product.name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    overflow: TextOverflow.ellipsis
                  ),
                  maxLines: 1,
                ),
            
              SizedBox(height: 4,),
              Text(
                  product.description,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
            
              SizedBox(height: 4,),
              //rating star
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffEAB308),
                    size: 14,
                  ),
                  SizedBox(width: 6,),
                  Text(
                    "${product.rating}",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              //Price with add to cart
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  AddToCartButton(
                    isAddedToCart: isAddedToCart,
                   onClick: (){onAddToCartPressed(product.id);})
                ],
              )

            ],
          ),
        )
      ),
    );
  }
}
