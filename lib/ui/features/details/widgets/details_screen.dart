import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/cards/product_details_card.dart';
import 'package:store/ui/features/details/view_models/details_view_model.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  final DetailsViewModel viewModel;
  const DetailsScreen({super.key, required this.id,required this.viewModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  initState(){
    super.initState();
    widget.viewModel.loadProductByIdCommand.execute(widget.id);
  }
  
  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.read<CartViewModel>();
    final favoriteViewModel = context.read<FavoriteViewModel>();
    return SafeArea(
      child: Scaffold(
        body: ListenableBuilder(
          listenable: widget.viewModel.loadProductByIdCommand,
          builder: (context, child) {
            if(widget.viewModel.loadProductByIdCommand.running){
                  return const Center(child: CircularProgressIndicator());
                }
                if(widget.viewModel.loadProductByIdCommand.error){
                  Center(
                    child: Text("Error: ${widget.viewModel.loadProductByIdCommand.result}"),
                  );
                }
                if(widget.viewModel.product == null){
                  return const Center(child: Text("No uiProduct found"));
                }
                debugPrint("product found, ${widget.viewModel.product!}");
                return child!;
          },
          child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context,child){
                if(widget.viewModel.product == null) {
                  return SizedBox();
                }
                return ProductDetailsCard(
                  product: widget.viewModel.product!,
                  isFavorite: context.select<FavoriteViewModel,bool>((vm)=>vm.isFavorite(widget.id)),
                  onToggleFavorite: (id){
                    favoriteViewModel.toggleFavorite(widget.viewModel.product!);
                  },
                );
              })

        )
      ),
    );
  }
}
