import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/controller/favoritesection_controller.dart';
import 'package:uidesign/controller/productdescription_controller.dart';
import 'package:uidesign/controller/homescreen_controller.dart';
import 'package:uidesign/controller/searchscreen_controller.dart';
import 'package:uidesign/route_services/route_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CartScreenController.initDb();
  await FavoritesectionController.initDb();

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
      create: (context) => SearchscreenController(),
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
