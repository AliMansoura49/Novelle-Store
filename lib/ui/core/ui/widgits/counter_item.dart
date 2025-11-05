import 'package:flutter/material.dart';

class CounterItem extends StatelessWidget{
  final int counter;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CounterItem({
    super.key,
    required this.counter,
    required this.onDecrease,
    required this.onIncrease
    });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //minus
        IconButton(
          onPressed: onDecrease,
           icon: Icon(
            Icons.remove,
            size: 14,
            color: colorScheme.primary,
            )
           )
        //counter
        ,Text(counter.toString(),style: textTheme.titleMedium,)
        //add
        ,IconButton(
          onPressed: onIncrease,
           icon: Icon(
            color: colorScheme.primary,
            Icons.add,
            size: 14,
            )
           )
      ],
    );
  }
}