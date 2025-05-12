import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog/core/resources/api_state.dart';
import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/usecases/get_product_by_id.dart';
import 'package:product_catalog/features/product/domain/usecases/get_saved_product_use_case.dart';
import 'package:product_catalog/features/product/domain/usecases/product_use_case.dart';
import 'package:product_catalog/features/product/domain/usecases/save_product_use_case.dart';
import 'package:product_catalog/features/product/domain/usecases/update_fav_use_case.dart';

class ProductController extends GetxController {
  final GetProductUseCase _getProductUseCase;
  final SaveProductUseCase _saveProductUseCase;
  final GetSavedProductUseCase _getLocalProductUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final UpdateFavUseCase _updateFavUseCase;
  final Rx<AppDataState<List<ProductItemEntity>>> appDataState =
      AppDataState<List<ProductItemEntity>>().obs;
  RxBool isNetworkUnavailable = false.obs;
  List<ReviewEntity> reviewList = <ReviewEntity>[];
  int selectedMediaPageIndex = 0;

  ProductResponseEntity productResponseEntity = ProductResponseEntity(
    limit: 10,
    products: [],
    skip: 0,
    total: 0,
  );

  ProductController(
    this._getProductUseCase,
    this._saveProductUseCase,
    this._getLocalProductUseCase,
    this._getProductByIdUseCase,
    this._updateFavUseCase,
  );

  Future<void> getAllProduct({bool isInit = false, String? search}) async {
    if (isInit) {
      productResponseEntity = productResponseEntity.copyWith(
        skip: 0,
        products: [],
        total: 0,
      );
      appDataState.value = appDataState.value.copyWith(
        apiState: ApiState.loading,
        data: [],
      );
    }

    if (productResponseEntity.total != 0 &&
        (productResponseEntity.products ?? []).isNotEmpty &&
        productResponseEntity.products!.length ==
            (productResponseEntity.total ?? 0)) {
      /// By ishwar
      // End paggination because we have all data

      return;
    }

    final productData = await _getProductUseCase.call({
      'skip': productResponseEntity.skip ?? 0,
      'search': search,
    });

    if (productData is DataError) {
      appDataState.value = appDataState.value.copyWith(
        apiState: ApiState.error,
        errorMessage: productData.error?.message,
      );
      if ((search ?? "").isEmpty) {
        getSavedProduct();
      }
    } else if (productData is DataSuccess && productData.data != null) {
      await _saveAllPrdouctsToLocal(productData.data?.products ?? []);
      if ((search ?? "").isNotEmpty) {
        productResponseEntity = productResponseEntity.copyWith(
          total: productData.data?.total,
          skip: (productResponseEntity.skip ?? 0) + 10,
          products: [
            ...(productResponseEntity.products ?? []),
            ...(productData.data?.products ?? []),
          ],
        );
      } else {
        await getSavedProduct(total: productData.data?.total);
      }

      appDataState.value = appDataState.value.copyWith(
        apiState: ApiState.done,
        data: productResponseEntity.products,
      );
    }
  }

  _saveAllPrdouctsToLocal(List<ProductItemEntity>? itemEntity) async {
    if (itemEntity != null && itemEntity.isNotEmpty) {
      for (var product in itemEntity) {
        await _getProductByIdUseCase.call(product.id ?? 0).then((value) async {
          if (value == null) {
            await _saveProductUseCase.call(product);
          }
        });
      }
    }
  }

  getSavedProduct({int? total}) {
    if (total == null) {
      appDataState.value = appDataState.value.copyWith(
        apiState: ApiState.loading,
      );
    }

    _getLocalProductUseCase.call(null).then((value) {
      productResponseEntity = productResponseEntity.copyWith(
        total: total,

        skip: (productResponseEntity.skip ?? 0) + 10,

        products: [...value],
      );
      appDataState.value = appDataState.value.copyWith(
        apiState: ApiState.done,
        data: productResponseEntity.products,
      );
    });
  }

  Future<void> updateFavStatus(
    int id,
    int isFavorite,
    ProductItemEntity? entities,
  ) async {
    await _getProductByIdUseCase.call(entities?.id ?? 0).then((value) async {
      if (value == null) {
        await _saveProductUseCase.call(entities!);
      }
    });

    await _updateFavUseCase.call({'id': id, 'isFavorite': isFavorite});
    if (isFavorite == 1) {
      productResponseEntity
          .products
          ?.firstWhere((element) => element.id == id)
          .isFavorite = 1;
    } else {
      productResponseEntity
          .products
          ?.firstWhere((element) => element.id == id)
          .isFavorite = 0;
    }
    appDataState.value = appDataState.value.copyWith(
      apiState: ApiState.done,
      data: productResponseEntity.products,
    );
  }

  Future checkInternet(BuildContext context) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.isNotEmpty &&
        connectivityResult.first != ConnectivityResult.none) {
      isNetworkUnavailable = false.obs;
      getAllProduct(isInit: true);
    } else {
      isNetworkUnavailable = true.obs;
      getSavedProduct();
      // Show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No internet connection',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  getProductReview(ProductItemEntity? productEntity) {
    List productReview = jsonDecode(productEntity?.reviews ?? "[]");
    if (productReview.isNotEmpty) {
      for (var review in productReview) {
        reviewList.add(
          ReviewEntity(
            comment: review['comment'],
            rating: (review['rating'] as num).toDouble(),
            reviewerName: review['reviewerName'],
            reviewerEmail: review['reviewerEmail'],

            date: DateTime.tryParse(review['date']),
          ),
        );
      }

      update();
    }
  }

  updateImagePageIndex(int selected) {
  selectedMediaPageIndex = selected;
  update();
  }
}
