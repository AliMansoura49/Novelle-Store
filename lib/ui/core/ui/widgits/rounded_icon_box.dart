import 'package:flutter/material.dart';

class RoundedIconBox extends StatelessWidget {
  final IconData icon;
  final double width;
  final double height;

  const RoundedIconBox({
    super.key,
    this.icon = Icons.shopping_bag_outlined,
    this.width = 60,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: colorScheme.primary,
        size: 32,
      ),
    );
  }
}