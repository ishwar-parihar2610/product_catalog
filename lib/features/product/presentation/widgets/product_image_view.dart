import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:product_catalog/features/product/presentation/controller/product_controller.dart';

/// {@template product_image_view}
/// ProductImageView widget.
/// {@endtemplate}
class ProductImageView extends StatelessWidget {
  final List<String>? images;
  final ProductController? productController;
  final PageController? pageController;

  final String? thumbnail;
  const ProductImageView({
    super.key,
    required this.images,
    required this.thumbnail,
    required this.productController,
    required this.pageController,
    // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SizedBox(
        height: 200,
        width: double.infinity,

        child: PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            productController?.updateImagePageIndex(value);
          },
          reverse: false,
          itemCount:
              images != null && (images ?? []).isNotEmpty ? images!.length : 1,
          itemBuilder:
              (context, index) => SizedBox(
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  height: 200,
                  width: 100,
                  imageUrl:
                      images != null && (images ?? []).isNotEmpty
                          ? images![index]
                          : thumbnail ?? "",
                ),
              ),
        ),
      ),

      GetBuilder<ProductController>(
        builder: (controller) {
          int selectedMediaPageIndex = controller.selectedMediaPageIndex ?? 0;
          return SizedBox(
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10),

              scrollDirection: Axis.horizontal,
              itemCount:
                  images != null && (images ?? []).isNotEmpty
                      ? images?.length ?? 0
                      : 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pageController?.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  child: Container(
                    height: 65,
                    width: 65,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow:
                          selectedMediaPageIndex == index
                              ? [
                                BoxShadow(
                                  color: Color.fromARGB(255, 221, 221, 221),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ]
                              : null,
                      border: Border.all(
                        width: selectedMediaPageIndex == index ? 2 : 1,
                        color:
                            selectedMediaPageIndex == index
                                ? Colors.black
                                : Colors.grey.withOpacity(0.5),
                      ),
                    ),

                    child: Center(
                      child: CachedNetworkImage(
                        height: 65,
                        width: 65,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,

                        imageUrl:
                            images != null && (images ?? []).isNotEmpty
                                ? images![index]
                                : thumbnail ?? "",
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    ],
  );
}
