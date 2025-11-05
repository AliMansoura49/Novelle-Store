import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/ui/core/ui/widgits/price_row.dart';
import 'package:store/ui/core/ui/tags/tag.dart';
import 'package:store/ui/core/ui/widgits/review_item.dart';

class ProductDetailsCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final Function(int) onToggleFavorite;

  const ProductDetailsCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image with discount
          Stack(
            children: [
              CachedNetworkImage(
                  imageUrl: product.images[0],
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    debugPrint("Error loading image: $error");
                    return Center(child: Icon(Icons.error));
                  },
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
            
              //backButton
              Positioned(
                top: 12,
                left: 12,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded
                  ),
                  iconSize: 28,
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainerHigh,
                    shape: CircleBorder(),
                  ),
                ),
              ),
              //tag,
              Positioned(
                top: 12,
                right: 12,
                child:  TagItem(
                    "-${product.discountPercentage.toStringAsFixed(0)}%",
                  ),
                ),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () {
                      onToggleFavorite(product.id);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                    iconSize: 32,
                    style: IconButton.styleFrom(
                      backgroundColor: isFavorite? null: Theme.of(context).colorScheme.surfaceContainerHigh,
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              //favorite icon button
            ],
          ),
          //title
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.brand != null) ...[
                    SizedBox(height: 16),
                    Text(
                        product.brand!,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                  
                  ],
                  SizedBox(height: 8),
                Text(
                      product.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                  SizedBox(height: 8),
                  //Category
                  Text(
                    product.category,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  //Price row
                  PriceRow(
                    price: product.price,
                    discountPercentage: product.discountPercentage,
                    rating: product.rating,
                  ),
                  SizedBox(height: 8),
                  //description
                Text(
                      product.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  //Shipment information
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          product.shippingInformation,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    "Customer Reviews",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  //Reviews
                  ...product.reviews.map(
                          (review) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ReviewItem(review: review),
                            );
                          },
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
