import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/api_services.dart';

class SearchscreenController with ChangeNotifier {
  List<ProductModel> productAllList = [];
  List<ProductModel> filteredDataList = [];
  bool isLoading = false;

  Future<void> getAllProduct() async {
    isLoading = true;
    notifyListeners();

    final allProductUrl = Uri.parse(ApiServices.searchUrl);
    try {
      var response = await http.get(allProductUrl);
      if (response.statusCode == 200) {
        var responses = json.decode(response.body) as List;
        productAllList =
            responses.map((data) => ProductModel.fromJson(data)).toList();
        filteredDataList = List.from(productAllList);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  void filterProduct(String query) {
    if (query.isEmpty) {
      filteredDataList = List.from(productAllList);
    } else {
      filteredDataList = productAllList.where((product) {
        bool titleMatch = product.title != null &&
            product.title!.toLowerCase().contains(query.toLowerCase());
        bool categoryMatch = product.category != null &&
            product.category!.name.toLowerCase().contains(query.toLowerCase());
        return titleMatch || categoryMatch;
      }).toList();
    }
    notifyListeners();
  }
}
