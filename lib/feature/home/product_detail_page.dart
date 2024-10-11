import 'package:animademo/core/model/product_model.dart';
import 'package:animademo/core/util/app_font.dart';
import 'package:animademo/core/util/colors.dart';
import 'package:animademo/core/util/sized_boxes.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailPage({required this.productModel, Key? key})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true); // Continuously run the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25,
                      color: black,
                    ),
                  ),
                  Transform.rotate(
                    angle: 270 * 3.1416 / 180,
                    child: Image.asset(
                      'assets/images/bose_logo_default.png',
                      width: 130,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Hero(
                tag: widget.productModel.id,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Image.network(
                        widget.productModel.imageUrl,
                        width: 430,
                        height: 250,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: grey,
                    ),
                    child: Text(
                      'Limited Edition',
                      style: AppFonts.mediumText.copyWith(color: whiteColor),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                      ),
                      sizedBoxWidth10,
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            shape: BoxShape.circle),
                      ),
                      sizedBoxWidth10,
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.cyan, shape: BoxShape.circle),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.cyan, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              widget.productModel.title,
              style: AppFonts.extraLargeText.copyWith(color: black),
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(backGroundColor)),
              onPressed: () {},
              label: Text('\$ ${widget.productModel.price.toInt().toString()}',
                  style: AppFonts.largeText.copyWith(color: black)),
              icon: const Icon(
                Icons.add_shopping_cart_rounded,
                size: 22,
                color: black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
