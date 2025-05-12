import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/presentation/controller/product_controller.dart';
import 'package:product_catalog/features/product/presentation/widgets/product_image_view.dart';
import 'package:product_catalog/features/product/presentation/widgets/product_review.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductItemEntity? productEntity;
  ProductController productController = Get.find<ProductController>();
  PageController pageController = PageController();

  @override
  void didChangeDependencies() {
    final argument = ModalRoute.of(context)?.settings.arguments;
    if (argument != null) {
      productEntity = (argument as Map)['product_details'] as ProductItemEntity;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        productController.getProductReview(productEntity);
      });
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    resetMediaPageIndex();
    super.initState();
  }

  resetMediaPageIndex() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productController.selectedMediaPageIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _addToCart(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            iconSize: 30,
            icon:
                productEntity?.isFavorite == 1
                    ? const Icon(Icons.favorite, color: Colors.black)
                    : const Icon(Icons.favorite_border),

            onPressed: () {
              productController.updateFavStatus(
                productEntity?.id ?? 0,
                productEntity?.isFavorite == 1 ? 0 : 1,
                productEntity,
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: 18,
            fontFamily:
                GoogleFonts.lato(
                  fontWeight: FontWeight.w600,

                  color: Colors.black,
                ).fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageView(
              pageController: pageController,
              productController: productController,
              thumbnail: productEntity?.thumbnail ?? "",
              images: (jsonDecode(productEntity?.images ?? '')).cast<String>(),
            ),
            _titleAndPrice(),
            _infoView(productEntity?.brand ?? ""),
            Divider(thickness: 0.3, color: Colors.grey, height: 30),
            Expanded(
              child: ListView(
                children: [
                  _infoView(productEntity?.description ?? ""),
                  GetBuilder<ProductController>(
                    builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Reviews",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.lato(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ).fontFamily,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (context, index) =>
                                        const SizedBox(height: 10),
                                itemCount: controller.reviewList.length,
                                itemBuilder: (context, index) {
                                  return ProductReview(
                                    reviewEntity: controller.reviewList[index],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _titleAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Text(
              productEntity?.title ?? "",
              style: TextStyle(
                fontSize: 16,
                fontFamily:
                    GoogleFonts.lato(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ).fontFamily,
              ),
            ),
          ),
          Text(
            "\$${productEntity?.price.toString() ?? ""}",
            style: TextStyle(
              fontSize: 18,
              fontFamily:
                  GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ).fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  _infoView(String? title) {
    if (title == null || title.isEmpty) {
      return const SizedBox();
    }
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontFamily:
            GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ).fontFamily,
      ),
    );
  }

  _addToCart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Successfully! Added to cart ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        child: Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Center(
            child: Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily:
                    GoogleFonts.lato(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ).fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
