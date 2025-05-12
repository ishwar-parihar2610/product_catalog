import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/features/product/data/models/product.dart';

abstract class ProductApiService {
  Future<DataState<ProductResponse>> getAllProduct(int skip, String? searchQuery,);
}
