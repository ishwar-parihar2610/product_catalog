import 'dart:async';

import 'package:floor/floor.dart';
import 'package:product_catalog/features/product/data/models/product.dart';

@dao
abstract class ProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(ProductItemModel product);

  @Query('SELECT id, title FROM product WHERE id = :id')
  Future<ProductItemModel?> getProduct(int id);

  @Query('SELECT * FROM product')
  Future<List<ProductItemModel>> getAllProducts();

  @Query('UPDATE product SET isFavorite = :isFavorite WHERE id = :id')
  Future<void> updateFavoriteProduct(int id, int isFavorite);
}
