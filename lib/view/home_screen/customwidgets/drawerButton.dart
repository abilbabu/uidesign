import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/controller/homescreen_controller.dart';
import 'package:uidesign/view/home_screen/product_screen/product_screen.dart';

class DrawerButtonscreen extends StatefulWidget {
  const DrawerButtonscreen({super.key});

  @override
  State<DrawerButtonscreen> createState() => _DrawerButtonscreenState();
}

class _DrawerButtonscreenState extends State<DrawerButtonscreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomescreenController>().getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<HomescreenController>(
        builder: (context, categoryController, child) {
          if (categoryController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const DrawerHeader(
                child: Text('Categories', style: TextStyle(fontSize: 24)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    String category = categoryController.categoryList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: categoryController.selectedCategory == category
                              ? Colors.grey[100]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(category),
                          onTap: () {
                            categoryController.onCategorySelection(category);
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreen(categoryName: category),
                              ),
                            );
                          },
                        ),
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
