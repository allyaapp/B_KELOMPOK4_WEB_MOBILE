import 'package:blackshop/models/DetailCategoryModels.dart';
import 'package:blackshop/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/ProductModels.dart';

class CategoryProductCard extends StatelessWidget {
  final DetailCategoryModels category;
  CategoryProductCard(this.category);
  // const AllProductCard({
  //   // Key? key,
  //   // required this.image,
  //   // required this.title,
  //   // required this.price,
  //   // required this.press,
  //   // required this.bgColor, required String subtitleProduct,
  // }) : super(key: key);
  // final String image, title;
  // final VoidCallback press;
  // final int price;
  // final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (() => Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => DetailsScreen(product),
      //       ),
      //     )
      // ),
      child: Container(
        // height: 250,
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Column(
          children: [
            Container(
              // height: 193,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: bgColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultBorderRadius)),
              ),
              child: Image.network(
                "https://blackshop.ws-tif.com/storage/products/" +
                    category.product![0].image.toString(),
                // height: 132,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    category.product![0].name.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  "Rp" + category.product![0].price.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
