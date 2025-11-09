import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/ui/features/favorite/widgets/favorite_grid.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorite Products"),
        leading: IconButton(
            onPressed: (){
              context.pop();
            },
            icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  FavoriteGrid()
        ),
    );
  }
}
