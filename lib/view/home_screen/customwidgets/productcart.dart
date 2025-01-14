import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/controller/favoritesection_controller.dart';
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';

class ProductCart extends StatefulWidget {
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
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed('product_description',
            pathParameters: {'productId': widget.productId.toString()});
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
                          image: NetworkImage(widget.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 10,
                    child: Consumer<FavoritesectionController>(
                      builder: (context, favoriteController, child) {
                        bool _isFavorited = favoriteController.FavStore.any(
                          (element) => element["productId"] == widget.productId,
                        );

                        return IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Added to Favorites!"),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            setState(() {
                              _isFavorited = !_isFavorited;
                            });

                            var product = ProductModel(
                              title: widget.title,
                              description: widget.description,
                              image: widget.image,
                              price: widget.price,
                              id: widget.productId,
                            );

                            if (_isFavorited) {
                              favoriteController.addFav(product);
                            } else {
                              favoriteController.removefav(widget.productId);
                            }
                          },
                          icon: Icon(
                            _isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 25,
                            color: _isFavorited
                                ? ColorConstants.redcolor
                                : ColorConstants.textDescriptiontextcolor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Text(widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.getPriceTextStyle(
                      fontSize: 18, color: ColorConstants.textcolor)),
              Text(widget.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.getSubTextStyle(
                      fontSize: 15,
                      color: ColorConstants.textDescriptiontextcolor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("\$${widget.price.toString()}",
                      style: AppStyle.getPriceTextStyle(
                          fontSize: 15, color: ColorConstants.textcolor)),
                  InkWell(
                    onTap: () async {
                      var product = ProductModel(
                        title: widget.title,
                        description: widget.description,
                        image: widget.image,
                        price: widget.price,
                        id: widget.productId,
                      );

                      bool isProductInCart = await context
                          .read<CartScreenController>()
                          .isProductInCart(widget.productId);

                      if (!isProductInCart) {
                        await context
                            .read<CartScreenController>()
                            .addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to cart!"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Already added cart!"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
