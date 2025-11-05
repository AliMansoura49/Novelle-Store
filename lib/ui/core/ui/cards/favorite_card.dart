import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/product/product.dart';

class FavoriteCard extends StatelessWidget {
  final Product product;
  final void Function(Product) onToggleFavorite;
  final void Function(int) onTap;

  const FavoriteCard({
    super.key,
    required this.product,
    required this.onToggleFavorite,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(

      onTap: (){
        onTap(product.id);
      },
      child: Card(
        color: colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: colorScheme.surfaceBright,
                  child: Stack(
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          imageUrl: product.thumbnail,
                          placeholder: (context, url) =>
                              Center(
                                  child: CircularProgressIndicator()
                              ),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: IconButton(
                              onPressed: (){
                                onToggleFavorite(product);
                              },
                            style: IconButton.styleFrom(
                              backgroundColor: colorScheme.secondaryContainer,
                              shape: CircleBorder()
                            ),
                              icon: Icon(
                                  Icons.favorite_outline,
                                  color: colorScheme.onSecondaryContainer,
                                  size: 22,
                                ),
                              ),
                            ),
                      ]
                  ),
                ),
              ),
              Expanded(flex: 1,child: SizedBox(),),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                product.brand??"no brand",
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant
                ),
              ),
              SizedBox(height: 4,),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                product.title,
                style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface
                ),
              ),
              SizedBox(height: 4,),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "\$${product.price.toStringAsFixed(2)}",
                style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant
                ),
              ),
              Expanded(flex: 1,child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
