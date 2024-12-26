import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uidesign/model/productModel/productModel.dart';

class ProductdescriptionController with ChangeNotifier {
  ProductModel? product;
  bool isloading = false;

  getproductDetail(int productId) async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        product = ProductModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }
}
