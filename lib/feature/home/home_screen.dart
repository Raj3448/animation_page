import 'dart:async';

import 'package:animademo/core/data/dummy_data.dart';
import 'package:animademo/core/util/app_font.dart';
import 'package:animademo/core/util/colors.dart';
import 'package:animademo/feature/home/component/product_component.dart';
import 'package:animademo/feature/home/product_detail_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: _isLoaded ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: AnimatedSlide(
                        offset: _isLoaded
                            ? const Offset(0, 0)
                            : const Offset(-1.5, 0),
                        duration: const Duration(milliseconds: 1500),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 25,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _isLoaded ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: AnimatedSlide(
                        offset: _isLoaded
                            ? const Offset(0, 0)
                            : const Offset(1.5, 0),
                        duration: const Duration(milliseconds: 1500),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search_rounded,
                            size: 25,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: _isLoaded ? 1.0 : 0.0,
                        duration: const Duration(seconds: 1),
                        child: AnimatedSlide(
                          offset: _isLoaded
                              ? const Offset(0, 0)
                              : const Offset(-1.5, 0),
                          duration: const Duration(milliseconds: 1500),
                          child: Text(
                            'Wireless Headphones',
                            style: AppFonts.extraLargeText
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _isLoaded ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: AnimatedSlide(
                        offset: _isLoaded
                            ? const Offset(0, 0)
                            : const Offset(1.5, 0),
                        duration: const Duration(milliseconds: 1500),
                        child: Transform.rotate(
                          angle: 270 * 3.1416 / 180,
                          child: Image.asset(
                            'assets/images/bose_light_logo.png',
                            width: 130,
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 3 / 4.5,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  bool isLeftColumn = (index % 2 == 0);
                  return AnimatedOpacity(
                    opacity: _isLoaded ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1500 + (index * 100)),
                    child: AnimatedSlide(
                      offset: _isLoaded
                          ? const Offset(0, 0)
                          : (isLeftColumn
                              ? const Offset(-1.5, 0)
                              : const Offset(1.5, 0)),
                      duration: Duration(milliseconds: 1500 + (index * 100)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              productModel: productList[index],
                            ),
                          ));
                        },
                        child: ProductComponent(
                          index: index,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
