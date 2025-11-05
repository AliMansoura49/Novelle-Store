import 'package:go_router/go_router.dart';
import 'package:store/domain/repositories/ProductsRepository.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/features/cart/widgets/cart_screen.dart';
import 'package:store/ui/features/details/view_models/details_view_model.dart';
import 'package:store/ui/features/favorite/widgets/favorite_screen.dart';
import 'package:store/ui/features/home/view_models/home_view_model.dart';
import 'package:store/ui/features/login/login_view_model/login_view_model.dart';
import 'package:store/ui/features/login/widgets/login_screen.dart';
import 'package:store/ui/features/signup/view_model/signup_view_model.dart';
import 'package:store/ui/features/signup/widgets/signup_screen.dart';
import '../ui/features/details/widgets/details_screen.dart';
import '../ui/features/home/widgets/home_screen.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.signup,
        builder: (context, state){
          return ChangeNotifierProvider(
            create: (context)=> SignupViewModel(),
            builder: (context,child)=> SignupScreen(),
          );
        }
      ),GoRoute(
        path: Routes.login,
        builder: (context, state){
          return ChangeNotifierProvider(
            create: (context)=> LoginViewModel(),
            builder: (context,child)=> LoginScreen(),
          );
        }
      ),
      GoRoute(
          path: Routes.home,
          builder: (context , state) => 
          ChangeNotifierProvider<HomeViewModel>(
            create: (context)=> HomeViewModel(
              repo: context.read<ProductRepository>()
            ),
            builder: (context, child) => HomeScreen()
            )
      ),
      GoRoute(
        path: Routes.productDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final detailsViewModel = DetailsViewModel(
            repo: context.read<ProductRepository>()
          );
          return DetailsScreen(id: id,viewModel: detailsViewModel,);
        }
      ),
      GoRoute(path: Routes.cart,
        builder: (context, state) => const CartScreen()
      ),
      GoRoute(
        path: Routes.favorite,
        builder: (context,state)=> const FavoriteScreen()
      )
    ]
);