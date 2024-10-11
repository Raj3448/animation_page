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
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late AnimationController _bottomController;
  late Animation<Offset> _slideAnimation;

  int _repeatCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: _getBeginScale(),
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener(_animationStatusListener);
    _controller.forward();

    _bottomController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _bottomController, curve: Curves.easeInOut),
    );

    _bottomController.forward();
  }

  double _getBeginScale() {
    if (_repeatCount == 0) {
      return 1.0;
    } else {
      return (2.0 - _repeatCount * 0.2).clamp(0.9, double.infinity);
    }
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _repeatCount++;
      if (_repeatCount < 5) {
        _controller.reverse();
      }
    } else if (status == AnimationStatus.dismissed) {
      if (_repeatCount < 5) {
        _controller.forward();
      }
    }

    _scaleAnimation = Tween<double>(
      begin: _getBeginScale(),
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _bottomController.dispose();
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
            _buildHeader(),
            _buildImage(),
            _buildProductDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
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
    );
  }

  Widget _buildImage() {
    return Expanded(
      child: Center(
        child: Hero(
          tag: widget.productModel.id,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.network(
                  widget.productModel.imageUrl,
                  width: 400,
                  height: 300,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLabelRow(),
            _buildProductTitle(),
            _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLimitedEditionLabel(),
          _buildColorOptions(),
        ],
      ),
    );
  }

  Widget _buildLimitedEditionLabel() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        'Limited Edition',
        style: AppFonts.mediumText.copyWith(color: whiteColor),
      ),
    );
  }

  Widget _buildColorOptions() {
    return Row(
      children: [
        _buildColorOption(Colors.amber),
        sizedBoxWidth10,
        _buildColorOption(Colors.deepOrangeAccent),
        sizedBoxWidth10,
        _buildColorOptionWithOutline(Colors.cyan),
      ],
    );
  }

  Widget _buildColorOption(Color color) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildColorOptionWithOutline(Color color) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: 30,
          width: 30,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _buildProductTitle() {
    return Text(
      widget.productModel.title,
      style: AppFonts.extraLargeText.copyWith(color: black),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton.icon(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backGroundColor),
      ),
      onPressed: () {},
      label: Text(
        '\$ ${widget.productModel.price.toInt()}',
        style: AppFonts.largeText.copyWith(color: black),
      ),
      icon: const Icon(
        Icons.add_shopping_cart_rounded,
        size: 22,
        color: black,
      ),
    );
  }
}
