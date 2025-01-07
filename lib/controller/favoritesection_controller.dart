import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesectionController with ChangeNotifier {
  static late Database database;
  List<Map<String, dynamic>> FavStore = [];

  static Future initDb() async {
    database = await openDatabase("cartdbfav.Db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, title TEXT, descrbtion TEXT, image TEXT, price REAL)');
    });
  }

  Future getfavorite() async {
    FavStore = await database.rawQuery('SELECT * FROM Cart');
    log(FavStore.toString());
    notifyListeners();
  }

  Future addFav(Map<String, dynamic> getFav) async {
    bool alreadyInCart =
        FavStore.any((element) => getFav["id"] == element["id"]);
    if (alreadyInCart) {
      log("Already in cart");
    } else {
      await database.rawInsert(
          'INSERT INTO Cart(title, descrbtion, image, price, ) VALUES(?, ?, ?, ?)',
          [
            getFav["title"],
            getFav["descrbtion"],
            getFav["image"],
            getFav["price"],
          ]);
    }
    notifyListeners();
  }

  Future removefav(int id) async {
    await database.rawDelete('DELETE FROM Cart WHERE id = ?', [id]);
    getfavorite();
  }
}
