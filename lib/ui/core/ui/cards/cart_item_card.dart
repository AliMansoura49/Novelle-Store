import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/ui/core/ui/widgits/counter_item.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double depth;
  final String title;
  final double weight;
  final double price;

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.depth,
    required this.title,
    required this.weight,
    required this.price,
    required this.onDecrease,
    required this.onDelete,
    required this.onIncrease,
    required this.onTap,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: colorScheme.surfaceContainerLowest,
        child: Padding(
          padding: EdgeInsets.all(10),
          child:  Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:CachedNetworkImage(
                      height: 90,
                      width: 90,
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>  Center(
                              child: CircularProgressIndicator()
                          ),
                          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                  ),
                  Flexible(child: SizedBox()),        //info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        title,
                        style: textTheme.titleMedium,
                      ),
                      Text(
                        "W: ${width}cm, H: ${height}cm, D: $depth",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Flexible(child: SizedBox()),
                      Text(
                        "Weight: ${weight}Kg",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                              textAlign: TextAlign.left,
                              "\$${price.toStringAsFixed(2)}",
                              style: textTheme.titleMedium,
                      ),
                  ],
                  ),
                ]
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: colorScheme.error,
                    size: 22,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CounterItem(
                    onDecrease: onDecrease,
                    onIncrease: onIncrease,
                    counter: quantity,
                  )
              ),
            ],
          )
        ),
      ),
    );
  }
}
