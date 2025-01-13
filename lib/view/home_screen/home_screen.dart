import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uidesign/controller/favoritesection_controller.dart';
import 'package:uidesign/controller/homescreen_controller.dart';
import 'package:uidesign/controller/searchscreen_controller.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/utils/constants/image_constants.dart';
import 'package:uidesign/view/home_screen/customwidgets/drawerButton.dart';
import 'package:uidesign/view/home_screen/customwidgets/productcart.dart';

class HomeScreen extends StatefulWidget {
  static var route;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomescreenController>().getProduct();
        context.read<SearchscreenController>().getAllProduct();
        context.read<HomescreenController>().getCategory();
        context.read<HomescreenController>().getCategoryAllProduct();
        context.read<FavoritesectionController>().getfavorite();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            _buildExploreSection(),
            _buildBestSellingSection(),
          ],
        ),
      ),
      drawer: const DrawerButtonscreen(),
    );
  }

  Widget _buildBestSellingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            'Best Selling',
            style: AppStyle.getTextStyle(
              fontSize: 28,
              color: ColorConstants.textcolor,
            ),
          ),
        ),
        Consumer<FavoritesectionController>(
          builder: (context, FavoriteController, child) {
            return FavoriteController.isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: List.generate(
                        FavoriteController.FavStore.length,
                        (index) {
                          final favoriteProduct =
                              FavoriteController.FavStore[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: ColorConstants.boxShadow,
                              ),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  favoriteProduct["image"]),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              favoriteProduct["title"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.getTextStyle(
                                                fontSize: 18,
                                                color: ColorConstants.textcolor,
                                              ),
                                            ),
                                            Text(
                                              favoriteProduct["description"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.getSubTextStyle(
                                                fontSize: 16,
                                                color: ColorConstants
                                                    .textDescriptiontextcolor,
                                              ),
                                            ),
                                            Text(
                                              '\$${favoriteProduct["price"]}',
                                              style: AppStyle.getPriceTextStyle(
                                                fontSize: 16,
                                                color: ColorConstants.textcolor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                              'product_description',
                                              pathParameters: {
                                                'productId':
                                                   favoriteProduct['id'].toString(),
                                              });// route pass
                                         
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ),
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
                  );
          },
        ),
      ],
    );
  }

  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            'Explore',
            style: AppStyle.getTextStyle(
              fontSize: 28,
              color: ColorConstants.textcolor,
            ),
          ),
        ),
        Consumer<HomescreenController>(
          builder: (context, productObj, child) {
            return productObj.isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300] ?? Colors.grey,
                    highlightColor: Colors.grey[100] ?? Colors.grey,
                    enabled: productObj.isLoading,
                    child: SizedBox(
                      height: 320,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const ProductCart(
                            image: '',
                            title: '',
                            description: '',
                            price: 0,
                            productId: 0,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 30),
                        itemCount: 2,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 320,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var product = productObj.productList[index];
                        return ProductCart(
                          image: product.image.toString(),
                          title: product.title.toString(),
                          description: product.description.toString(),
                          price: product.price!,
                          productId: product.id!,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 30),
                      itemCount: productObj.productList.length,
                    ),
                  );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        children: [
          Container(
            width: 280,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: ColorConstants.boxShadow,
            ),
            child: TextField(
              onChanged: (query) {
                Provider.of<SearchscreenController>(context, listen: false)
                    .filterProduct(query);
              },
              onSubmitted: (query) {
                Provider.of<SearchscreenController>(context, listen: false)
                    .filterProduct(query);
                context.pushNamed('search_screen');// route pass
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: AppStyle.getSubTextStyle(
                  fontSize: 14,
                  color: ColorConstants.textDescriptiontextcolor,
                ),
                prefixIcon:
                    const Image(image: AssetImage(ImageConstants.searchlogo)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: ColorConstants.textDescriptiontextcolor,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              context.pushNamed("cart_screen");// route pass
            },
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Image(image: AssetImage(ImageConstants.cartlogo)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 81, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: const Image(image: AssetImage(ImageConstants.drawer)),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 3.25, vertical: 2.17),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Image(image: AssetImage(ImageConstants.profile)),
          ),
        ],
      ),
    );
  }
}
