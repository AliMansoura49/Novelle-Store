import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/widgits/shimmer_row.dart';
import 'package:store/ui/features/home/view_models/home_view_model.dart';

import '../../../core/ui/widgits/filters_row.dart';
class HomeTopSection extends StatelessWidget {
  const HomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return ListenableBuilder(
      listenable: viewModel.getCategoryListCommand,
      builder: (context, child) {
        if(viewModel.categoryListRunning){
          return SizedBox(height: 40,child: ShimmerRow());
        }
        if(viewModel.categoryListError){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Failed to load categories"),
                const SizedBox(height: 8),
                ElevatedButton(
                  key: ValueKey("retry_button"),
                  onPressed: () => viewModel.getCategoryListCommand.execute(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
        return child!;
      },
      child: ValueListenableBuilder(
          valueListenable: viewModel.selectedFilterIndex,
          builder: (context,value,child){
            final categories = viewModel.categoryList;
    
            return FiltersRow(
              key: ValueKey("filters_row"),
              labels: [
                "All",
                ...categories
              ],
                selectedIndex: value,
                onFilterSelected: (index,isSelected){
                  viewModel.updateIndex(index,viewModel.categoryList[index]);
                },
            );
          }
      ),
    );
  }
}
