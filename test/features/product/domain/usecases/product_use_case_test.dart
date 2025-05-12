import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_catalog/core/constant/constants.dart';
import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/features/product/data/models/product.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/usecases/product_use_case.dart';

import '../../../../mocks/mock_product_repository.mocks.dart';

void main() {
  late GetProductUseCase getProductUseCase;
  late MockProductRepository mockProductRepository;

  setUpAll(() {
    mockProductRepository = MockProductRepository();
    getProductUseCase = GetProductUseCase(mockProductRepository);
  });

  ProductResponse dummyProductResponse = ProductResponse.fromJson({
    "total": 194,
    "skip": 0,
    "limit": 10,
    "products": [
      {
        "id": 1,
        "title": "Essence Mascara Lash Princess",
        "description":
            "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
        "category": "beauty",
        "price": 9.99,
        "discountPercentage": 10.48,
        "rating": 2.56,
        "stock": 99,
        "tags": ["beauty", "mascara"],
        "brand": "Essence",
        "sku": "BEA-ESS-ESS-001",
        "weight": 4,
        "dimensions": {"width": 15.14, "height": 13.08, "depth": 22.99},
        "warrantyInformation": "1 week warranty",
        "shippingInformation": "Ships in 3-5 business days",
        "availabilityStatus": "In Stock",
        "reviews": [
          {
            "rating": 3,
            "comment": "Would not recommend!",
            "date": "2025-04-30T09:41:02.053Z",
            "reviewerName": "Eleanor Collins",
            "reviewerEmail": "eleanor.collins@x.dummyjson.com",
          },
          {
            "rating": 4,
            "comment": "Very satisfied!",
            "date": "2025-04-30T09:41:02.053Z",
            "reviewerName": "Lucas Gordon",
            "reviewerEmail": "lucas.gordon@x.dummyjson.com",
          },
          {
            "rating": 5,
            "comment": "Highly impressed!",
            "date": "2025-04-30T09:41:02.053Z",
            "reviewerName": "Eleanor Collins",
            "reviewerEmail": "eleanor.collins@x.dummyjson.com",
          },
        ],
        "returnPolicy": "No return policy",
        "minimumOrderQuantity": 48,
        "meta": {
          "createdAt": "2025-04-30T09:41:02.053Z",
          "updatedAt": "2025-04-30T09:41:02.053Z",
          "barcode": "5784719087687",
          "qrCode": "https://cdn.dummyjson.com/public/qr-code.png",
        },
        "images": [
          "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp",
        ],
        "thumbnail":
            "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp",
      },
    ],
  });

  ProductResponseEntity productResponseEntity = ProductResponseEntity(
    limit: dummyProductResponse.limit,
    products: dummyProductResponse.products?.map((e) => e).toList(),
  );

  test("it should be return list of products", () async {
    when(mockProductRepository.getAllProduct(0, "")).thenAnswer(
      (realInvocation) =>
          Future.value(DataSuccess(data: productResponseEntity)),
    );

    final resultData = await getProductUseCase.call({"skip": 0, "search": ""});

    expect(resultData, isA<DataSuccess<ProductResponseEntity>>());
    expect(resultData.data, equals(productResponseEntity));
  });

  test("check failure case", () async {
    when(mockProductRepository.getAllProduct(0, "")).thenAnswer(
      (realInvocation) => Future.value(
        DataError(
          error: DioException(
            requestOptions: RequestOptions(path: productApiBaseUrl),
            type: DioExceptionType.unknown,
            error: "parsing exception",
          ),
        ),
      ),
    );

    final resultData = await getProductUseCase.call({"skip": 0, "search": ""});

    expect(resultData, isA<DataError>());

    expect((resultData).error, isA<DioException>());
    expect((resultData).error?.type, equals(DioExceptionType.unknown));
    expect((resultData).error?.error, equals("parsing exception"));
  });

  test("check no internet case", () async {
    when(mockProductRepository.getAllProduct(0, "")).thenAnswer(
      (realInvocation) => Future.value(
        DataError(
          error: DioException(
            requestOptions: RequestOptions(path: productApiBaseUrl),
            type: DioExceptionType.connectionError,
            error:
                "No internet connection. Please check your network.", // Error message
          ),
        ),
      ),
    );

    final resultData = await getProductUseCase.call({"skip": 0, "search": ""});

    expect(resultData, isA<DataError>());

    expect((resultData).error, isA<DioException>());
    expect((resultData).error?.type, equals(DioExceptionType.connectionError));
    expect(
      (resultData).error?.error,
      equals("No internet connection. Please check your network."),
    );
  });
}
