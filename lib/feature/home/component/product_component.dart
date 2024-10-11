import 'package:animademo/core/data/dummy_data.dart';
import 'package:animademo/core/util/app_font.dart';
import 'package:animademo/core/util/colors.dart';
import 'package:flutter/material.dart';

class ProductComponent extends StatelessWidget {
  final int index;
  const ProductComponent({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: productList[index].id,
            child: Image.network(
              productList[index].imageUrl,
              width: 130,
              height: 150,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productList[index].title,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  '\$ ${productList[index].price.toInt().toString()}',
                  style: AppFonts.mediumText.copyWith(color: grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
