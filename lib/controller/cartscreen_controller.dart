import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uidesign/model/productModel/productModel.dart';


class CartScreenController with ChangeNotifier {
  static late Database database;
  double totalCartvalue = 0.00;

  List<Map<String, dynamic>> storedProducts = [];

  static Future initDb() async {
    database = await openDatabase("cartdatabase.Db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, title TEXT,qty INTEGER ,price REAL,image TEXT,productId INTEGER)');
    });
  }

  Future getAllProduct() async {
    storedProducts = await database.rawQuery('SELECT * FROM Cart');
    log(storedProducts.toString());
    calculateTotalAmount();
    notifyListeners();
  }

  Future addProduct(ProductModel getProduct) async {
    bool alreadyCart = storedProducts.any(
      (element) => getProduct.id == element["productId"],
    );

    if (alreadyCart) {
      log("already in cart");
    } else {
      await database.rawInsert(
          'INSERT INTO Cart(title, qty, price,image,productId) VALUES(?, ?, ?, ?, ?)',
          [
            getProduct.title,
            1,
            getProduct.price,
            getProduct.image,
            getProduct.id
          ]);
    }
    notifyListeners();
  }

// update to
  incrementQty({required int currentQty, required int id}) {
    database
        .rawUpdate('UPDATE Cart SET qty  = ? WHERE id = ?', [++currentQty, id]);
    getAllProduct();
  }

  decrementQty({required int currentQty, required int id}) {
    if (currentQty > 1) {
      database.rawUpdate(
          'UPDATE Cart SET qty  = ? WHERE id = ?', [--currentQty, id]);
      getAllProduct();
    }
  }

  removeProduct(int id) async {
    await database.rawDelete('DELETE FROM Cart WHERE id  = ?', [id]);
    getAllProduct();
  }

  void calculateTotalAmount() {
    totalCartvalue = 0.00;
    for (int i = 0; i < storedProducts.length; i++) {
      totalCartvalue = totalCartvalue +
          (storedProducts[i]["qty"] * storedProducts[i]["price"]);
    }
    // for (var element in storedProducts) {
    //   totalCartvalue = totalCartvalue + (element["qty"] + element["price"]);
    // }
    log(totalCartvalue.toString());
  }
Future<void> cleardata() async {
  await database.delete("Cart");
}
  
}