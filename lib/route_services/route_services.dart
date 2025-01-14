import 'package:go_router/go_router.dart';
import 'package:uidesign/view/cart_screen/cart_screen.dart';
import 'package:uidesign/view/home_screen/home_screen.dart';
import 'package:uidesign/view/home_screen/product_screen/product_screen.dart';
import 'package:uidesign/view/home_screen/search_screen/search_screen.dart';
import 'package:uidesign/view/product_description/product_description.dart';
import 'package:uidesign/view/profile_screen/profile_screen.dart';

final router = GoRouter(initialLocation: '/home_screen', routes: [
  GoRoute(
    path: "/home_screen",
    name: "home_screen",
    builder: (context, state) {
      return HomeScreen();
    },
  ),

  //product description screen route pass
  GoRoute(
    path: "/product_description/:productId",
    name: "product_description",
    builder: (context, state) {
      var productId = state.pathParameters['productId'];
      return ProductDescription(
        productId: int.parse(productId!),
      );
    },
  ),

    //cart screen route pass
     GoRoute(
    path: "/cart_screen",
    name: "cart_screen",
    builder: (context, state) {
      return CartScreen();
    },
  ),

  // category drawer pass
    GoRoute(
      path: "/product_screen/:categoryName",
      name: "product_screen",
      builder: (context, state) {
        var categoryName = state.pathParameters['categoryName']!;
        return ProductScreen(
          categoryName: categoryName,
        );
      },
    ),

    //search screen route pass
     GoRoute(
    path: "/search_screen",
    name: "search_screen",
    builder: (context, state) {
      return SearchScreen();
    },
  ),

  GoRoute(
    path: "/profile_screen",
    name: "profile_screen",
    builder: (context, state) {
      return ProfileScreen();
    },
  ),
]);
