import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/routing/router.dart';
import 'package:store/ui/core/theme/theme.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';
import 'data/repositories/products/product_repository_remote.dart';
import 'domain/repositories/ProductsRepository.dart';
import 'data/services/api/product_api_service.dart';

void main(){
  runApp(
      MultiProvider(
        providers: [
          Provider(create: (context)=> ProductApiService()),
          Provider(
            create: (context)=>
            ProductRepositoryRemote(
                productApiService: context.read<ProductApiService>()
            ) as ProductRepository
            ,
          ),
          //Shared ViewModels
          ChangeNotifierProvider(
              create: (context)=> CartViewModel()
          ),
          ChangeNotifierProvider(
              create: (context)=> FavoriteViewModel()
          ),
      ],
        child: MainApp(),
      )
  );
 }

 class MainApp extends StatelessWidget {
   const MainApp({super.key});

   @override
   Widget build(BuildContext context) {
     return MaterialApp.router(
       debugShowCheckedModeBanner: false,
       theme: AppTheme.lightTheme,
       darkTheme: AppTheme.darkTheme,
       themeMode: ThemeMode.system,
       routerConfig: router(),
     );
   }
 }
 