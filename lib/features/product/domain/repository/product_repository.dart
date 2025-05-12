import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/features/product/data/models/product.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<DataState<ProductResponseEntity>> getAllProduct(
    int skip,
    String? search,
  );

  Future<List<ProductItemModel>> getSavedProducts();

  Future<void> saveProduct(ProductItemEntity productItemEntity);

  Future<ProductItemModel?> getProductById(int id);


  Future<void> updateProductFavStatus(int id,int isFavorite);


}
