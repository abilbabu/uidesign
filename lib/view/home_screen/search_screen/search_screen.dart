import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/searchscreen_controller.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/view/home_screen/customwidgets/customAppbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Map<int, bool> _favoriteStates = {};

  @override
  Widget build(BuildContext context) {
    final filteredData =
        Provider.of<SearchscreenController>(context).filteredDataList;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const CustomAppBar(),
          Consumer(
            builder: (context, value, child) {
              return filteredData.isEmpty
                  ? Expanded(
                      child: Center(
                          child: Text("No products found",
                              style: AppStyle.getTextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.textcolor))),
                    )
                  : Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final productId = index;
                          final product = filteredData[index];
                          final isFavorite =
                              _favoriteStates[productId] ?? false;
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                product.image.toString()),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _favoriteStates[productId] =
                                                !isFavorite;
                                          });
                                        },
                                        icon: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 25,
                                          color: isFavorite
                                              ? ColorConstants.redcolor
                                              : ColorConstants
                                                  .textDescriptiontextcolor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.title.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.getTextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.textcolor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.description.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.getSubTextStyle(
                                    fontSize: 15,
                                    color:
                                        ColorConstants.textDescriptiontextcolor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      product.price.toString(),
                                      style: AppStyle.getPriceTextStyle(
                                        fontSize: 16,
                                        color: ColorConstants.textcolor,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Add to cart action
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
                          );
                        },
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
