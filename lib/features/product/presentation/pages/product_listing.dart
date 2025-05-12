import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_catalog/core/resources/api_state.dart';
import 'package:product_catalog/features/product/presentation/controller/product_controller.dart';
import 'package:product_catalog/features/product/presentation/widgets/product_skeleton.dart';
import 'package:product_catalog/features/product/presentation/widgets/product_widget.dart';
import 'package:product_catalog/features/product/presentation/widgets/search_text_field.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({super.key});

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  TextEditingController searchTextEditingController = TextEditingController();
  final ProductController productController = Get.find<ProductController>();
  late ScrollController productGridScrollController;
  Timer? debounce;

  getProuctList() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => productController.checkInternet(context),
    );
  }

  @override
  void initState() {
    print("navigate");
    productGridScrollController = ScrollController();

    productGridScrollController.addListener(onPageScrolled);
    getProuctList();
    super.initState();
  }

  @override
  void dispose() {
    debounce?.cancel();

    super.dispose();
  }

  onPageScrolled() {
    if (productGridScrollController.position.pixels ==
        productGridScrollController.position.maxScrollExtent) {
      if (!productController.isNetworkUnavailable.value) {
        productController.getAllProduct(
          search: searchTextEditingController.text,
        );
      } else {
        print("no network");
      }
    }
  }

  Future searchProduct() async {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      await productController.getAllProduct(
        search: searchTextEditingController.text,
        isInit: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchTextField(
                controller: searchTextEditingController,
                onClear: () {
                  searchTextEditingController.clear();
                  getProuctList();
                },
                onChanged: (p0) {
                  searchProduct();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Product Catalog",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily:
                        GoogleFonts.lato(
                          fontWeight: FontWeight.w600,

                          color: Colors.black,
                        ).fontFamily,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  final productState = productController.appDataState.value;
                  return productState.apiState == ApiState.loading
                      ? ProductSkeleton()
                      : productState.apiState == ApiState.error
                      ? Center(
                        child: Text(
                          productState.errorMessage ?? "Error",
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                      : productState.data != null &&
                          productState.data!.isNotEmpty
                      ? ProductWidget(
                        onRefresh: () async {
                          productController.checkInternet(context);
                        },
                        productController: productController,
                        productList: productState.data ?? [],
                        productGridScrollController:
                            productGridScrollController,
                      )
                      : productController.isNetworkUnavailable.value
                      ? RefreshIndicator(
                        onRefresh:
                            () async =>
                                await productController.checkInternet(context),

                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.wifi_off,
                                    size: 50,
                                    color: Colors.grey.shade400,
                                  ),
                                  Text(
                                    "No internet connection",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            searchTextEditingController.text.isEmpty
                                ? "Sorry, no products found"
                                : "Sorry, no products found related to '${searchTextEditingController.text}'.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
