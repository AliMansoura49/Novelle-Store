import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/ui/cards/favorite_card.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';
import 'package:store/ui/features/favorite/widgets/favorite_screen.dart';

import '../../../../mocks/mocks.dart';

void main(){
  late FavoriteViewModel favoriteViewModel;

  setUp((){
    favoriteViewModel = FavoriteViewModel();
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider.value(
      value: favoriteViewModel,
      child: MaterialApp(
        home: FavoriteScreen(),
      ),
    );
  }

  group('FavoriteGrid Widget Tests', () {
    testWidgets('displays message when no favorite products are added', (WidgetTester tester) async {

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.text("No favorite products added yet."), findsOneWidget);
    });

    testWidgets('show a Grid of items when there are some favorite items', (tester)async{

      favoriteViewModel.addToFavorites(mockProduct);
      favoriteViewModel.addToFavorites(mockProduct2);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
      expect (find.byType(FavoriteCard), findsNWidgets(2));
      
    });
  });

}