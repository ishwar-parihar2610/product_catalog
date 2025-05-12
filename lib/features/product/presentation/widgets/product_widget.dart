import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog/config/routes/app_routes.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/presentation/controller/product_controller.dart';

class ProductWidget extends StatelessWidget {
  final List<ProductItemEntity> productList;
  final ScrollController productGridScrollController;
  final ProductController productController;
  final Future Function() onRefresh;

  const ProductWidget({
    super.key,
    required this.productList,
    required this.productGridScrollController,
    required this.productController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      child: GridView.builder(
        itemCount: productList.length,
        controller: productGridScrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,

          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 210,
        ),
        itemBuilder: (context, index) {
          final productEntity = productList[index];
          return GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  AppRoutes.productDetails,
                  arguments: {"product_details": productEntity},
                ),
            child: Container(
              height: 200,
              padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.zero,
                      iconSize: 20,

                      onPressed:
                          () => productController.updateFavStatus(
                            productEntity.id ?? 0,
                            productEntity.isFavorite == 1 ? 0 : 1,
                            productEntity,
                          ),
                      icon:
                          productEntity.isFavorite == 1
                              ? Icon(Icons.favorite, color: Colors.black)
                              : Icon(Icons.favorite_border),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 100,
                          width: 100,
                          imageUrl: productEntity.thumbnail ?? "",
                        ),

                        Text(
                          productEntity.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          productEntity.brand ?? "",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                '\$${productEntity.price}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${productEntity.discountPercentage}% Off",
                                  maxLines: 1,

                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
