import 'package:flutter/material.dart';

class ClickableImage extends StatelessWidget {
  final String assetUrl;
  final VoidCallback onTap;
  const ClickableImage({
    super.key,
    required this.assetUrl,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: BoxShape.circle,
        ),
        child: Image.asset(assetUrl, height: 40,width: 40,),
      ),
    );
  }
}