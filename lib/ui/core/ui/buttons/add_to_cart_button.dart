import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final bool isAddedToCart;
  final VoidCallback onClick;
  const AddToCartButton({
    super.key,
    required this.isAddedToCart,
    required this.onClick
    });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: IconButton(
        onPressed: onClick,
        icon: Icon(Icons.check),
        iconSize: 22,
        style: IconButton.styleFrom(
          backgroundColor: Color(0xff32CE6E),
          foregroundColor: Theme.of(context).colorScheme.primary,
          disabledForegroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 6
          )
        ),
        ), 
      secondChild: IconButton(
        onPressed: onClick,
        icon: Icon(Icons.shopping_bag_outlined),
        iconSize: 22,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.primary,
          disabledForegroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 6
          )
        ),
        ), 
      crossFadeState: isAddedToCart?
      CrossFadeState.showFirst: CrossFadeState.showSecond, 
      duration: Duration(milliseconds: 400)
      );
  }
  
}