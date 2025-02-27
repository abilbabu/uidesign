import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/controller/productdescription_controller.dart';
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/home_screen/customwidgets/customAppbar.dart';

class ProductDescription extends StatefulWidget {
  final int productId;

  static var route;

  const ProductDescription({super.key, required this.productId});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context
            .read<ProductdescriptionController>()
            .getproductDetail(widget.productId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductdescriptionController>(
        builder: (context, value, child) {
          if (value.isloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.product == null) {
            return const Center(
              child: Text('Product not found'),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 390,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(30)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    value.product!.image.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          CustomAppBar()
                        ],
                      ),
                      // Product Info Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('\$ ${value.product!.price.toString()}',
                                    style: AppStyle.getPriceTextStyle(
                                        fontSize: 20,
                                        color: ColorConstants.redcolor)),
                                const Spacer(),
                                const Icon(
                                  Icons.star,
                                  color: ColorConstants.yellowcolor,
                                ),
                                Text(value.product!.rating!.rate.toString(),
                                    style: AppStyle.getTextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.textcolor)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(value.product!.title.toString(),
                                style: AppStyle.getTextStyle(
                                    fontSize: 20,
                                    color: ColorConstants.textcolor)),
                            const SizedBox(height: 20),
                            Text(
                              'Color Options',
                              style: AppStyle.getTextStyle(
                                fontSize: 14,
                                color: ColorConstants.textcolor,
                              ),
                            ),
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: ColorConstants.redcolor,
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: ColorConstants.textcolor,
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.blue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Text(
                              "Description",
                              style: AppStyle.getTextStyle(
                                fontSize: 18,
                                color: ColorConstants.textcolor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(value.product!.description.toString(),
                                style: AppStyle.getSubTextStyle(
                                    fontSize: 16,
                                    color: ColorConstants
                                        .textDescriptiontextcolor)),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 40,
                right: 40,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("haiiii");
                      var product = ProductModel(
                        title: value.product!.title!,
                        description: value.product!.description!,
                        image: value.product!.image!,
                        price: value.product!.price!,
                        id: widget.productId,
                      );

                      context.read<CartScreenController>().addProduct(product);
                      context.read<CartScreenController>().getAllProduct();
                      context.pushNamed('cart_screen'); // route pass
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          'Add to Cart',
                          style: AppStyle.getTextStyle(
                            fontSize: 18,
                            color: ColorConstants.whitecolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
