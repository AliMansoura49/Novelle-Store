import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String content;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const TagItem(this.content,{
    super.key,
    this.backgroundColor ,
    this.foregroundColor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerColor = backgroundColor ?? theme.colorScheme.errorContainer;
    final contentColor = foregroundColor ?? theme.colorScheme.onErrorContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 14
      ),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: contentColor
        )
      ),
    );
  }
}
