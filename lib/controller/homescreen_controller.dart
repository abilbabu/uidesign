import 'dart:convert';
// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/api_services.dart';

class HomescreenController with ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> categoryListData = [];
  List catecoryList = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  String selectedCategory = "electronics";
  bool isloading = false;
  

  //* Fetching products (limited to 8)
  Future<void> getproduct() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(ApiServices.limitproductUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // log(response.body);
        var product = productModelFromJson(response.body);
        productList = product;
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  //* Fetching categories
  Future<void> getCategory() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(ApiServices.categoryUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // log(response.body);
        var convertjson = jsonDecode(response.body);
        catecoryList = List.from(convertjson);
      }
    } catch (e) {
      print(e);
    }isloading = false;
    notifyListeners();
  }

  //* Fetch all products or products based on the selected category
  Future<void> getAllProduct() async {
    isloading = true;
    notifyListeners();

    final allCategoryProductUrl = Uri.parse(
        "https://fakestoreapi.com/products/category/${selectedCategory}");

    try {
      var response = await http.get(allCategoryProductUrl);

      if (response.statusCode == 200) {
        // log(response.body);
        var responses = productModelFromJson(response.body);
        categoryListData = responses;
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  onCategorySelection(String clicked) async {
    if (selectedCategory != clicked && isloading == false) {
      selectedCategory = clicked;
      notifyListeners();
    }
    await getAllProduct();
  }
}
