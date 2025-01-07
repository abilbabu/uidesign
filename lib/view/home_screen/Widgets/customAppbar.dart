import 'package:flutter/material.dart';
import 'package:uidesign/utils/constants/color_constants.dart';
import 'package:uidesign/utils/constants/image_constants.dart';
import 'package:uidesign/view/home_screen/home_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String? title; 
  
  const CustomAppBar({
    Key? key, 
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
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
          title != null 
          ? Center(
              child: Text(
                title!,
                style: const TextStyle(
                  color: ColorConstants.textcolor,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                ),
              ),
            )
          : const SizedBox.shrink(),
          
          const SizedBox(
              width: 40,
              height: 40,
              child: Image(image: AssetImage(ImageConstants.cartlogo))),
        ],
      ),
    );
  }
}
