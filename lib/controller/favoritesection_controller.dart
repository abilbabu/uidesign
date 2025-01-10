import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uidesign/model/productModel/productModel.dart';

class FavoritesectionController with ChangeNotifier {
  static late Database database;
  List<Map<String, dynamic>> FavStore = [];
  bool isloading = false;

  static Future<void> initDb() async {
    database = await openDatabase(
      "cartdb2.Db",
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Cart (id INTEGER PRIMARY KEY, title TEXT, description TEXT, image TEXT, price REAL, productId INTEGER)');
      },
    );
  }

  getfavorite() async {
    isloading = true;
    notifyListeners();
    FavStore = await database.rawQuery('SELECT * FROM Cart');
    // log(FavStore.toString());
    isloading = false;
    notifyListeners();
  }

  Future<void> addFav(ProductModel getFav) async {
    bool alreadyInCart = FavStore.any(
      (element) => getFav.id == element["productId"],
    );

    if (alreadyInCart) {
      log("Already in favorites");
      return;
    }
    await database.rawInsert(
      'INSERT INTO Cart(title, description, image, price, productId) VALUES(?, ?, ?, ?, ?)',
      [
        getFav.title,
        getFav.description,
        getFav.image,
        getFav.price,
        getFav.id,
      ],
    );
    getfavorite();
  }

  Future<void> removefav(int productId) async {
    await database
        .rawDelete('DELETE FROM Cart WHERE productId = ?', [productId]);
    getfavorite();
  }
}
