
import 'package:flutter/material.dart';

class FiltersRow extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int index,bool isSelected) onFilterSelected;


  const FiltersRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onFilterSelected,
  });



  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.onPrimary;
    final unselectedColor = Theme.of(context).colorScheme.onSurface;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16,
        children: [
          ...labels.map((filter){
            final isSelected = labels.indexOf(filter) == selectedIndex;
            return ChoiceChip(
              selectedColor: Theme.of(context).colorScheme.primary ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)
              ),
              showCheckmark: false,
              selected: isSelected,
              label: Text(
                  filter,
                style: TextStyle(
                  color: (isSelected) ? selectedColor : unselectedColor,
                ),
              ),
              onSelected: (bool selected){
                onFilterSelected(labels.indexOf(filter),selected);
              },
            );
          })
        ]
      ),
    );
  }
}

