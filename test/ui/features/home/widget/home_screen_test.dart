import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/ui/core/ui/cards/productItemCard.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';
import 'package:store/ui/features/home/view_models/home_view_model.dart';
import 'package:store/ui/features/home/widgets/home_screen.dart';
import 'package:store/utils/result.dart';

import '../../../../mocks/fake_command.dart';
import '../../../../mocks/mocks.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockHomeViewModel mockHomeVM;
  late MockCartViewModel mockCartVM;
  late MockFavoriteViewModel mockFavVM;

  setUp(() {
    mockHomeVM = MockHomeViewModel();
    mockCartVM = MockCartViewModel();
    mockFavVM = MockFavoriteViewModel();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>.value(value: mockHomeVM),
        ChangeNotifierProvider<CartViewModel>.value(value: mockCartVM),
        ChangeNotifierProvider<FavoriteViewModel>.value(value: mockFavVM),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }

  group('HomeTopSection Widget Tests', () {
    setUp(() {
      when(mockHomeVM.pagingController).thenReturn(
        PagingController<int, Product>(
          getNextPageKey: (_) => null,
          fetchPage: (_) async => <Product>[],
        ),
      );
      when(
        mockHomeVM.getCategoryListCommand,
      ).thenReturn(FakeCommand<List<int>>());
    });
    testWidgets('should show loading when categoryListRunning is true', (
      tester,
    ) async {
      // arrange

      when(mockHomeVM.categoryListRunning).thenReturn(true);
      when(mockHomeVM.categoryListError).thenReturn(false);

      when(mockHomeVM.selectedFilterIndex).thenReturn(ValueNotifier(0));
      when(mockHomeVM.categoryList).thenReturn([]);

      //act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'should show error text with retry button when categoryListError is true',
      (tester) async {
        when(mockHomeVM.categoryListRunning).thenReturn(false);
        when(mockHomeVM.categoryListError).thenReturn(true);

        when(mockHomeVM.selectedFilterIndex).thenReturn(ValueNotifier(0));
        when(mockHomeVM.categoryList).thenReturn([]);

        //act
        await tester.pumpWidget(createWidgetUnderTest());

        final retryButtonFinder = find.byKey(ValueKey("retry_button"));
        final errorTextFinder = find.text("Failed to load categories");

        expect(retryButtonFinder, findsOneWidget);
        expect(errorTextFinder, findsOneWidget);
      },
    );
    testWidgets(
      'should show filters row when successfully catygoryList been loaded',
      (tester) async {
        when(mockHomeVM.categoryListRunning).thenReturn(false);
        when(mockHomeVM.categoryListError).thenReturn(false);
        when(mockHomeVM.selectedFilterIndex).thenReturn(ValueNotifier(0));
        when(
          mockHomeVM.categoryList,
        ).thenReturn(["beauty", "electronics", "jewelery"]);

        await tester.pumpWidget(createWidgetUnderTest());

        final filtersRowFinder = find.byKey(ValueKey("filters_row"));

        expect(filtersRowFinder, findsOneWidget);
      },
    );
  });

  group('HomeBody WidgetTest', () {
    setUp(() {
      when(mockHomeVM.categoryListRunning).thenReturn(false);
      when(mockHomeVM.categoryListError).thenReturn(false);
      when(mockHomeVM.selectedFilterIndex).thenReturn(ValueNotifier(0));
      when(
        mockHomeVM.categoryList,
      ).thenReturn(["beauty", "electronics", "jewelery"]);

      when(mockFavVM.isFavorite(any)).thenReturn(false);
      when(mockCartVM.isAddedToCart(any)).thenReturn(false);
    });

    testWidgets(
      'should show a gridView of products when successfully been loaded',
      (tester) async {
        when(mockHomeVM.pagingController).thenReturn(
          PagingController<int, Product>(
            value: PagingState(
              hasNextPage: false,
              pages: [
                [mockProduct],
              ],
              keys: [0],
            ),
            getNextPageKey: (_) => null,
            fetchPage: (_) async => <Product>[],
          ),
        );
        when(mockHomeVM.getCategoryListCommand).thenReturn(
          FakeCommand<List<Product>>(
            isCompleted: true,
            isRunning: false,
            hasError: false,
            result: Result.ok([]),
          ),
        );

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(Duration(seconds: 1));
        final gridViewFinder = find.byType(PagedGridView<int, Product>);
        final productCardFinder = find.byType(ProductItemCard);

        expect(gridViewFinder, findsOneWidget);
        expect(productCardFinder, findsOneWidget);
      },
    );

    testWidgets('should show empty text when there is no data', (tester) async {
      when(mockHomeVM.pagingController).thenReturn(
        PagingController<int, Product>(
          getNextPageKey: (_) => 0,
          fetchPage: (_) async {
            return <Product>[];
          },
        ),
      );
      when(mockHomeVM.getCategoryListCommand).thenReturn(
        FakeCommand<List<Product>>(
          isCompleted: true,
          isRunning: false,
          hasError: false,
          result: Result.ok([]),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(Duration(seconds: 1));
      final emptyTextFinder = find.text("No items found");
      expect(emptyTextFinder, findsOneWidget);
    });
    testWidgets(
      'should show circular progress indicator when loading the first page',
      (tester) async {
        when(mockHomeVM.pagingController).thenReturn(
          PagingController<int, Product>(
            getNextPageKey: (_) => 0,
            fetchPage: (_) async {
              // simulate a pending fetch so the first-page loading indicator is shown
              await Future.delayed(const Duration(milliseconds: 500));
              return <Product>[];
            },
          ),
        );

        when(mockHomeVM.getCategoryListCommand).thenReturn(
          FakeCommand<List<Product>>(
            isCompleted: true,
            isRunning: false,
            hasError: false,
            result: Result.ok([]),
          ),
        );

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'should show error text when error is found',
      (tester) async {
        // Arrange
        final pagingController = PagingController<int, Product>(
          value: PagingState(
            hasNextPage: false,
            isLoading: false,
            error: Exception("Test error"),
            pages: [
              
            ],
            keys: [],
          ),
          getNextPageKey: (_) => null,
          fetchPage: (_) async => <Product>[],
        );

        when(mockHomeVM.pagingController).thenReturn(pagingController);
        when(mockHomeVM.getCategoryListCommand).thenReturn(
          FakeCommand<List<Product>>(
            isCompleted: true,
            isRunning: false,
            hasError: false,
            result: Result.ok([]),
          ),
        );
        when(mockFavVM.isFavorite(any)).thenReturn(false);
        when(mockCartVM.isAddedToCart(any)).thenReturn(false);

        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(
          const Duration(milliseconds: 100),
        );

        // Assert
        expect(find.text("Error was found"), findsWidgets);
      },
    );
    testWidgets(
      'should show circular progress indicator at the bottom of the grid when new data is loading',
      (tester) async {
        // Arrange
        final pagingController = PagingController<int, Product>(
          value: PagingState(
            hasNextPage: true,
            isLoading: true,
            pages: [
              [mockProduct],
            ],
            keys: [0],
          ),
          getNextPageKey: (_) => null,
          fetchPage: (_) async => <Product>[],
        );

        when(mockHomeVM.pagingController).thenReturn(pagingController);
        when(mockHomeVM.getCategoryListCommand).thenReturn(
          FakeCommand<List<Product>>(
            isCompleted: true,
            isRunning: false,
            hasError: false,
            result: Result.ok([]),
          ),
        );
        when(mockFavVM.isFavorite(any)).thenReturn(false);
        when(mockCartVM.isAddedToCart(any)).thenReturn(false);

        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(
          const Duration(milliseconds: 100),
        ); // 

        // Assert
        expect(find.byType(CircularProgressIndicator), findsWidgets);
      },
    );
  });
}
