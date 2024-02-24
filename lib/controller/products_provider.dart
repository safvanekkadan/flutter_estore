import 'package:estore/model/categories_model.dart';
import 'package:estore/model/products_model.dart';
import 'package:estore/model/users_model.dart';
import 'package:estore/service/api_fetch.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductsModel> products = [];
  List<CategoriesModel> categories = [];
  List<UsersModel> users = [];
  bool isLoading = false;
  String error = '';

  Future<void> getAllProducts({required String limit}) async {
    isLoading = true;
    notifyListeners();

    try {
      List<dynamic> temp =
          await APIHandler.getData(target: 'products', limit: limit);
      products = ProductsModel.productsFromSnapshot(temp);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
