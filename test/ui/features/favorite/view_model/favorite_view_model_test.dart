
import 'package:flutter_test/flutter_test.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late FavoriteViewModel sut;
  late int listenerCounter;

  setUp(() {
    sut = FavoriteViewModel();
    listenerCounter = 0;
    sut.addListener(() {
      listenerCounter++;
    });
  });

  test('initial setup', () {
    expect(sut.favorites, isEmpty);
  });

  group('addToFavorites', () {
    test('should add a new item to favorites', () {
      //act
      sut.addToFavorites(mockProduct);

      //assert
      expect(listenerCounter, 1);
      expect(sut.favorites.length, 1);
      expect(sut.favorites[0], mockProduct);
    });

    test('should not add an item if it is already in favorites', () {
      // Arrange
      sut.addToFavorites(mockProduct);
      
      // Act
      sut.addToFavorites(mockProduct); 
      
      // Assert
      // Listener should not be called a second time if the state doesn't change
      expect(listenerCounter, 1); 
      expect(sut.favorites.length, 1);
    });
  });


  group('removeFromFavorites', () {
    test('should remove an item when calling remove method', () {
      //Arrange
      sut.addToFavorites(mockProduct);

      //Act
      sut.removeFromFavorites(mockProduct);

      //Assert
      expect(listenerCounter, 2);
      expect(sut.favorites, isEmpty);
    });

    test('should not trigger a notification if the item does not exist', () {
      // Arrange
      final anotherProduct = mockProduct.copyWith(id: 99);
      sut.addToFavorites(mockProduct); // listener counter = 1

      // Act
      sut.removeFromFavorites(anotherProduct);

      // Assert
      expect(listenerCounter, 1); 
      expect(sut.favorites.length, 1);
    });
  });

  group('isFavorite', () {
    test('should return true when given an existent id', () {
      //Arrange
      sut.addToFavorites(mockProduct);
      //Act
      final result = sut.isFavorite(1);
      //Assert
      expect(result, true);
    });
    test('should return false when given a non existent id', () {
      //Arrange
      sut.addToFavorites(mockProduct);
      //Act
      final result = sut.isFavorite(2);
      //Assert
      expect(result, false);
    });
  });

  group('toggleFavorite', () {
    test('should add product to favorites if it is not already there', () {
      //Act
      sut.toggleFavorite(mockProduct);
      //Assert
      expect(sut.favorites.length, 1);
      expect(listenerCounter, 1);
    });

    test('should remove product from favorites if it is already there', () {
      //Arrange
      sut.addToFavorites(mockProduct);
      //Act
      sut.toggleFavorite(mockProduct);
      //Assert
      expect(sut.favorites, isEmpty);
      expect(listenerCounter, 2);
    });
  });
}
