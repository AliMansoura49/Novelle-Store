
import 'package:flutter/material.dart';
import 'package:store/ui/core/ui/widgits/stars_rating.dart';

class PriceRow extends StatelessWidget {
  final double price;
  final double discountPercentage;
  final double rating;
  const PriceRow({super.key,required this.price, required this.discountPercentage, required this.rating});

  @override
    Widget build(BuildContext context) {
    final priceAfterDiscount = price * (1 - discountPercentage / 100);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "\$${priceAfterDiscount.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),        
        SizedBox(width: 20),
        Text(
          "\$${price.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            decoration: TextDecoration.lineThrough
          ),
        
        ), 
        Expanded(child: SizedBox()),
        StarsRating(rating: rating,iconSize: 22,),
        SizedBox(width: 16),
        Text(
          "(${rating.toStringAsFixed(1)})",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          )
        ),
      ],
    );
  }
}
