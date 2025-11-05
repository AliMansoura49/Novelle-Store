
import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final bool isFavorite;
  final void Function() onClick;
  const FavButton({super.key, required this.isFavorite,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: IconButton(
        onPressed: onClick,
        icon: Icon(Icons.favorite),
        color: Theme.of(context).colorScheme.primary,
        iconSize: 22,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        )),
       secondChild: IconButton(
        onPressed: onClick,
        icon: Icon(Icons.favorite_border),
        color: Theme.of(context).colorScheme.onSurface,
        iconSize: 22,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        )),
        crossFadeState: isFavorite?
        CrossFadeState.showFirst:CrossFadeState.showSecond, 
        duration: Duration(milliseconds: 400),
      );
  }
}
