import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/homescreen_controller.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/utils/constants/image_constants.dart';
import 'package:uidesign/view/cart_screen/cart_screen.dart';
import 'package:uidesign/view/home_screen/home_screen.dart';
import 'package:uidesign/view/product_description/product_description.dart';

class ProductScreen extends StatelessWidget {
  final String categoryName;
  const ProductScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    var categoryController = Provider.of<HomescreenController>(context);
    bool isProductLoading = categoryController.isProductloading;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorConstants.textDescriptiontextcolor,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Text(categoryName,
                    style: AppStyle.getTextStyle(
                        fontSize: 20, color: ColorConstants.textcolor)),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Image(image: AssetImage(ImageConstants.cartlogo))),
              ),
            ],
          ),
          isProductLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: ColorConstants.textcolor,
                ))
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    return InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDescription(productId: productId!),
                          ),
                          (route) => false,
                        );
                      },
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
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          size: 25,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    //
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
    );
  }
}
