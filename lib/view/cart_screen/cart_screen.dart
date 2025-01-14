import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/home_screen/customwidgets/customAppbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<CartScreenController>(context, listen: false).getAllProduct();
  }

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
                        horizontal: 16, vertical: 10),
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: ColorConstants.boxShadow),
                      child: Stack(
                        children: [
                          Row(
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
                                          .storedProducts[index]["image"]
                                          .toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          CartController.storedProducts[index]
                                                  ["title"]
                                              .toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyle.getTextStyle(
                                              fontSize: 18,
                                              color: ColorConstants.textcolor)),
                                      Text(
                                          CartController.storedProducts[index]
                                                  ["description"]
                                              .toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyle.getSubTextStyle(
                                              fontSize: 16,
                                              color: ColorConstants
                                                  .textDescriptiontextcolor)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              '\$ ${CartController.storedProducts[index]["price"]}',
                                              style: AppStyle.getPriceTextStyle(
                                                  fontSize: 18,
                                                  color: ColorConstants
                                                      .textcolor)),
                                          InkWell(
                                            onTap: () {
                                              CartController.decrementQty(
                                                  currentQty: CartController
                                                          .storedProducts[index]
                                                      ["qty"],
                                                  id: CartController
                                                          .storedProducts[index]
                                                      ["id"]);
                                            },
                                            child: const Text("-",
                                                style: TextStyle(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorConstants
                                                        .textcolor)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(13),
                                            child: Text(
                                                CartController
                                                    .storedProducts[index]
                                                        ["qty"]
                                                    .toString(),
                                                style: AppStyle.getTextStyle(
                                                    fontSize: 20,
                                                    color: ColorConstants
                                                        .redcolor)),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await CartController.incrementQty(
                                                  currentQty: CartController
                                                          .storedProducts[index]
                                                      ["qty"],
                                                  id: CartController
                                                          .storedProducts[index]
                                                      ["id"]);
                                            },
                                            child: const Text("+",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorConstants
                                                        .textcolor)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 5,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: ColorConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                onPressed: () async {
                                  await CartController.removeProduct(
                                      CartController.storedProducts[index]
                                          ["id"]);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Amount:-",
                            style: TextStyle(
                                color: const Color(0xFFC1C1C1),
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          Text(
                            "\$ ${CartController.totalCartvalue.toStringAsFixed(2)}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: const Row(
                          children: [
                            Text(
                              "CHECKOUT",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
