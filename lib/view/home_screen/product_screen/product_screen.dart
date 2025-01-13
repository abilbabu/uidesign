import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/cartscreen_controller.dart';
import 'package:uidesign/controller/favoritesection_controller.dart';
import 'package:uidesign/controller/homescreen_controller.dart';
import 'package:uidesign/model/productModel/productModel.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/home_screen/customwidgets/customAppbar.dart';


class ProductScreen extends StatefulWidget {
  final String categoryName;
  const ProductScreen({super.key, required this.categoryName});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Map<int, bool> _favoriteStates = {};

  @override
  Widget build(BuildContext context) {
    var categoryController = Provider.of<HomescreenController>(context);
    bool isProductLoading = categoryController.isLoading;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomAppBar(
              title: widget.categoryName,
            ),
            isProductLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: ColorConstants.textcolor,
                  ))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: categoryController.categoryListData.length,
                    itemBuilder: (context, index) {
                      var categoryProduct =
                          categoryController.categoryListData[index];
                      var productId = categoryProduct.id;

                      if (productId == null) {
                        return const SizedBox.shrink();
                      }

                      if (!_favoriteStates.containsKey(productId)) {
                        _favoriteStates[productId] = false;
                      }

                      return InkWell(
                        onTap: () {
                          context.pushNamed('product_description',
                              pathParameters: {
                                'productId': categoryProduct.id.toString(),
                              });
                        },// route pass
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 10,
                                spreadRadius: 0,
                              )
                            ],
                          ),
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
                                          image: NetworkImage(
                                              categoryProduct.image.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 10,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _favoriteStates[productId] =
                                                  !_favoriteStates[productId]!;
                                            });

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text("Added to cart!"),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );

                                            var product = ProductModel(
                                              title: categoryProduct.title,
                                              description:
                                                  categoryProduct.description,
                                              image: categoryProduct.image,
                                              price: categoryProduct.price,
                                              id: categoryProduct.id,
                                            );
                                            if (_favoriteStates[productId]!) {
                                              context
                                                  .read<
                                                      FavoritesectionController>()
                                                  .addFav(product);
                                            } else {
                                              context
                                                  .read<
                                                      FavoritesectionController>()
                                                  .removefav(productId);
                                            }
                                            context
                                                .read<
                                                    FavoritesectionController>()
                                                .getfavorite();
                                          },
                                          icon: Icon(
                                            _favoriteStates[productId]!
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 25,
                                            color: _favoriteStates[productId]!
                                                ? ColorConstants.redcolor
                                                : ColorConstants
                                                    .textDescriptiontextcolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(categoryProduct.title.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.getTextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.textcolor)),
                              Text(categoryProduct.description.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.getSubTextStyle(
                                      fontSize: 15,
                                      color: ColorConstants
                                          .textDescriptiontextcolor)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$ ${categoryProduct.price.toString()}",
                                    style: AppStyle.getPriceTextStyle(
                                        fontSize: 16,
                                        color: ColorConstants.textcolor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      var product = ProductModel(
                                        title: categoryProduct.title,
                                        description:
                                            categoryProduct.description,
                                        image: categoryProduct.image,
                                        price: categoryProduct.price,
                                        id: categoryProduct.id,
                                      );
                                      context
                                          .read<CartScreenController>()
                                          .addProduct(product);
                                      context
                                          .read<CartScreenController>()
                                          .getAllProduct();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Added to cart!"),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
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
                      );
                    },
                  ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
