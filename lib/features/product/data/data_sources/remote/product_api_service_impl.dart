import 'dart:io';

import 'package:dio/dio.dart';
import 'package:product_catalog/core/constant/constants.dart';
import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/features/product/data/data_sources/remote/product_api_service.dart';
import 'package:product_catalog/features/product/data/models/product.dart';

class ProductApiServiceImpl implements ProductApiService {
  final Dio dio;

  ProductApiServiceImpl({required this.dio});

  @override
  Future<DataState<ProductResponse>> getAllProduct(
    int skip,
    String? searchQuery,
  ) async {
    String apiUrl = productApiBaseUrl;
    if ((searchQuery ?? "").isNotEmpty) {
      apiUrl = "$productApiBaseUrl/search";
    }

    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {
          if ((searchQuery ?? "").isNotEmpty) "q": "$searchQuery",
          "limit": 10,
          "skip": skip,
        },
      );

      if (response.statusCode == 200) {
        final ProductResponse productList = ProductResponse.fromJson(
          response.data,
        );

        return DataSuccess(data: productList);
      } else {
        return DataError(
          error: DioException(
            requestOptions: RequestOptions(path: productApiBaseUrl),
            response: response,
            type: DioExceptionType.badResponse,
            message: "Unexpected status code: ${response.statusCode}",
          ),
        );
      }
    } on DioException catch (dioError) {
      print("reach here ${dioError.error}");

      if (dioError.type == DioExceptionType.connectionError ||
          dioError.error is SocketException) {
        print("reach on internet error");
        return DataError(
          error: DioException(
            requestOptions: dioError.requestOptions,
            type: DioExceptionType.connectionError,

            message: "No internet connection. Please check your network.",
          ),
        );
      }

      return DataError(error: dioError);
    } catch (e) {
      print("reach here $e");
      return DataError(
        error: DioException(
          requestOptions: RequestOptions(path: productApiBaseUrl),
          type: DioExceptionType.unknown,
          message: e.toString(),
        ),
      );
    }
  }
}
