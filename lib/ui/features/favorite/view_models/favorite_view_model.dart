import 'package:flutter/foundation.dart';

import '../../../../domain/models/product/product.dart';

class FavoriteViewModel extends ChangeNotifier{
  final List<Product> _favorites = [];
  List<Product> get favorites => _favorites;

  bool isFavorite(int id){
    return _favorites.any((p)=>p.id == id);
  }

  addToFavorites(Product product){
    if(!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }
  removeFromFavorites(Product product){
    _favorites.remove(product);
    notifyListeners();
  }

  toggleFavorite(Product product){
    isFavorite(product.id)?removeFromFavorites(product):addToFavorites(product);
  }

}