import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/product_description/product_description.dart';

class ProductCart extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final num price;
  final int productId;

  const ProductCart({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescription(
              productId: productId,
            ),
          ),
          (route) => false,
        );
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: ColorConstants.boxShadow),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.getPriceTextStyle(
                      fontSize: 18, color: ColorConstants.textcolor)),
              Text(description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.getSubTextStyle(
                      fontSize: 15,
                      color: ColorConstants.textDescriptiontextcolor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("\$${price.toString()}",
                      style: AppStyle.getPriceTextStyle(
                          fontSize: 15, color: ColorConstants.textcolor)),
                  InkWell(
                    onTap: () {
                      final product = ProductModel(
                        image: image,
                        title: title,
                        description: description,
                        price: price,
                      );
                      context.read<CartScreenController>().addProduct(product);
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
