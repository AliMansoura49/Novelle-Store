import 'package:flutter/material.dart';

class SeparatorLabel extends StatelessWidget {
  final String text;
  const SeparatorLabel({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(thickness: 1,)),
        SizedBox(width: 16,),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
        ),
        SizedBox(width: 16,),
        Expanded(child: Divider(thickness: 1,))
      ],
    );
  }
}
