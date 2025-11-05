import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  final double rating;
  final Color color;
  final double iconSize;
  final int maxStars;
  const StarsRating({
    super.key,
    required this.rating,
    this.color = Colors.amber,
    this.iconSize = 18,
    this.maxStars = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        if (index < rating.floor()) {
          return Icon(
            Icons.star, 
            color: color,
            size: iconSize,
            );
        } else if (index < rating) {
          return Icon(
            Icons.star_half,
            color: color,
            size: iconSize,
            );
        } else {
          return Icon(Icons.star_border, color: color,size: iconSize,);
        }
      }),
    );
  }
}