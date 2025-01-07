import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/home_screen/customwidgets/customAppbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<CartScreenController>(
      builder: (context, CartController, child) {
        return Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const CustomAppBar(
              title: "cart",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: CartController.storedProducts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: ColorConstants.boxShadow),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(CartController
                                          .storedProducts[index]["image"]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        CartController.storedProducts[index]
                                            ["title"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyle.getTextStyle(
                                            fontSize: 18,
                                            color: ColorConstants.textcolor)),
                                    Text(
                                        CartController.storedProducts[index]
                                            ["description"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyle.getSubTextStyle(
                                            fontSize: 16,
                                            color: ColorConstants
                                                .textDescriptiontextcolor)),
                                    Row(
                                      children: [
                                        Text(
                                            '\$ ${CartController.storedProducts[index]["price"].toString()}',
                                            style: AppStyle.getPriceTextStyle(
                                                fontSize: 18,
                                                color:
                                                    ColorConstants.textcolor)),
                                        const SizedBox(width: 80),
                                        ElevatedButton(
                                          onPressed: () {
                                            CartController.decrementQty(
                                                currentQty: CartController
                                                        .storedProducts[index]
                                                    ["qty"],
                                                id: CartController
                                                        .storedProducts[index]
                                                    ["id"]);
                                          },
                                          child: const Text(
                                            "-",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    ColorConstants.textcolor),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(13),
                                          child: Text(
                                              CartController
                                                  .storedProducts[index]["qty"]
                                                  .toString(),
                                              style: AppStyle.getTextStyle(
                                                  fontSize: 20,
                                                  color:
                                                      ColorConstants.redcolor)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await CartController.incrementQty(
                                              currentQty: CartController
                                                  .storedProducts[index]["qty"],
                                              id: CartController
                                                  .storedProducts[index]["id"],
                                            );
                                          },
                                          child: const Text(
                                            "+",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    ColorConstants.textcolor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 0,
                          child: IconButton(
                            onPressed: () async {
                              await CartController.removeProduct(
                                  CartController.storedProducts[index]["id"]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    ));
  }
}
