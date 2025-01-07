import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/controller/favoritesection_controller.dart';
import 'package:uidesign/controller/productdescription_controller.dart';
import 'package:uidesign/controller/homescreen_controller.dart';
import 'package:uidesign/view/home_screen/home_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomescreenController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductdescriptionController(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartScreenController(),
    ),
     ChangeNotifierProvider(
      create: (context) => FavoritesectionController(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
