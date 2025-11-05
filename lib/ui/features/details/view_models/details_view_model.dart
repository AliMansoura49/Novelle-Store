import 'package:flutter/material.dart';
import 'package:store/domain/repositories/ProductsRepository.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/utils/Command.dart';
import 'package:store/utils/result.dart';

class DetailsViewModel extends ChangeNotifier {
  final ProductRepository repo;
  DetailsViewModel({
    required this.repo
    }){
      loadProductByIdCommand = Command1(_getProductById);
    }

  late Command1<dynamic,int> loadProductByIdCommand;
  Product? _product;
  Product? get product => _product;


  Future<Result<Product>> _getProductById(int id) async {
    try {
      final result = await repo.getProductById(id);
      switch (result) {
        case Ok():
          _product = result.value;
        case Error():
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

}
