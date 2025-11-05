import 'package:flutter/material.dart';

class CartBottomBar extends StatelessWidget {
  final double subtotal;
  final double shipping;

  final Function()? onCheckout;

  const CartBottomBar({
    super.key,
    required this.subtotal,
    this.shipping = 5.0,
    required this.onCheckout
    });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: colorScheme.surfaceContainerLowest,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant
                  ),
                ),
                Text(
                  "\$${subtotal.toStringAsFixed(2)}",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            //Shipping
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant
                  ),
                ),
                Text(
                  "\$${shipping.toStringAsFixed(2)}",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            //Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "\$${(subtotal + shipping).toStringAsFixed(2)}",
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 12,),
            Divider(),
            SizedBox(height: 12,),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shadowColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                onPressed: onCheckout,
                child: Text(
                  "Proceed to Checkout",
                )
                ),
            )
          ],
        )
    ));
  }
}