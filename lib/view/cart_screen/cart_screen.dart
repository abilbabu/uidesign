import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/home_screen/Widgets/customAppbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartScreenController>(
        builder: (context, cartController, child) {
          return Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              CustomAppBar(
                title: "cart",
              ),
              // Main cart list
              Expanded(
                child: cartController.storedProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No items in your cart!',
                          style: TextStyle(
                              fontSize: 18, color: ColorConstants.textcolor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartController.storedProducts.length,
                        itemBuilder: (context, index) {
                          final product = cartController.storedProducts[index];
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Stack(
                              children: [
                                Container(
                                  height: 120,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                product[
                                                    "image"], // Fixed access
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(product["title"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyle.getTextStyle(
                                                    fontSize: 18,
                                                    color: ColorConstants
                                                        .textcolor)),
                                            Text(product["description"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyle.getSubTextStyle(
                                                    fontSize: 16,
                                                    color: ColorConstants
                                                        .textDescriptiontextcolor)),
                                            Row(
                                              children: [
                                                Text(
                                                    '\$ ${product["price"].toString()}',
                                                    style: AppStyle
                                                        .getPriceTextStyle(
                                                            fontSize: 18,
                                                            color: ColorConstants
                                                                .textcolor)),
                                                const SizedBox(width: 40),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await cartController
                                                        .incrementQty(
                                                      currentQty:
                                                          product["qty"],
                                                      id: product["id"],
                                                    );
                                                  },
                                                  child: const Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: ColorConstants
                                                            .textcolor),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      product["qty"].toString(),
                                                      style:
                                                          AppStyle.getTextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  ColorConstants
                                                                      .redcolor)),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    cartController.decrementQty(
                                                      currentQty:
                                                          product["qty"],
                                                      id: product["id"],
                                                    );
                                                  },
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: ColorConstants
                                                            .textcolor),
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
                                      await cartController
                                          .removeProduct(product["id"]);
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
      ),
    );
  }
}
