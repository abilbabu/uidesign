import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/api_services.dart';

class HomescreenController with ChangeNotifier {
  List<ProductModel> productList = [];
  
  List<ProductModel> categoryListData = [];

  List<String> categoryList = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  String selectedCategory = "electronics";

  bool isLoading = false;

  

  // Fetch limited product data
  Future<void> getProduct() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(ApiServices.limitproductUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var product = productModelFromJson(response.body);
        productList = product;
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  // Fetch all categories
  Future<void> getCategory() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(ApiServices.categoryUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var convertJson = jsonDecode(response.body);
        categoryList = List<String>.from(convertJson);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  // Fetch products based on selected category
  Future<void> getCategoryAllProduct() async {
    isLoading = true;
    notifyListeners();
    final allCategoryProductUrl = Uri.parse(
        "https://fakestoreapi.com/products/category/$selectedCategory");

    try {
      var response = await http.get(allCategoryProductUrl);
      if (response.statusCode == 200) {
        var responses = productModelFromJson(response.body);
        categoryListData = responses;
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> onCategorySelection(String clicked) async {
    if (selectedCategory != clicked && !isLoading) {
      selectedCategory = clicked;
      notifyListeners();
    }
    await getCategoryAllProduct();
  }
}
