
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RedirectText extends StatelessWidget {
  final String text;
  final String redirectText;
  final VoidCallback onTap;
  const RedirectText({
    super.key,
    required this.onTap,
    required this.text,
    required this.redirectText,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        children: [
          TextSpan(
            text: " $redirectText",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onTap,
          ),
        ],
      ),
    )
    ;
  }
}
