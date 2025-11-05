import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:store/domain/repositories/ProductsRepository.dart';
import 'package:store/utils/Command.dart';

import '../../../../domain/models/product/product.dart';
import '../../../../utils/result.dart';
import 'dart:developer';

class HomeViewModel extends ChangeNotifier {
  final ProductRepository repo;
  late PagingController<int,Product> pagingController;

  HomeViewModel({required this.repo}) {
    getCategoryListCommand = Command0(_getCategoryList)..execute();
    _initPageController();
  }

  void _initPageController({String category = "All"}){
    pagingController = PagingController<int,Product>(
        getNextPageKey: (PagingState<int, Product> state) {
          return state.lastPageIsEmpty ? null : state.nextIntPageKey;
        },
        fetchPage: (int pageKey) async{
          log(name: "HomeViewModel","category: $category ,pageKey: $pageKey ");
          return getProducts(pageKey: pageKey,category: category);
        }
    );
    notifyListeners();
  }

  final ValueNotifier<int> _selectedFilterIndex = ValueNotifier(0);
  ValueNotifier<int> get selectedFilterIndex => _selectedFilterIndex;

  List<String> _categoryList = [];
  List<String> get categoryList => _categoryList;

  //Commands
  late Command0 getCategoryListCommand;

  bool get categoryListRunning => getCategoryListCommand.running;
  bool get categoryListError => getCategoryListCommand.error;

  @visibleForTesting
  FutureOr<List<Product>> getProducts({required int pageKey,String category = "All"}) async{
    final result = (category == "All") ?
    await repo.getAllProducts(page: pageKey):
    await repo.getProductsByCategory(category);

    switch(result){
      case Ok(value: final data):
        return data;
      case Error(error: final error):
        throw(error);
    }
  }


  Future<Result<List<String>>> _getCategoryList() async {
    try {
      final result = await repo.getCategoryList();
      switch (result) {
        case Ok<List<String>>():
          _categoryList = result.value;
        case Error<List<String>>():
          log("Error was founded", name: "HomeViewModel");
      }

      return result;
    } finally {
      notifyListeners();
    }
  }

  updateIndex(int newIndex,String category) {
    _selectedFilterIndex.value = newIndex;
    _initPageController(category: category);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }
}
