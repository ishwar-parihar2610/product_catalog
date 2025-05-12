import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/features/product/data/data_sources/app_database.dart';
import 'package:product_catalog/features/product/data/data_sources/remote/product_api_service.dart';
import 'package:product_catalog/features/product/data/models/product.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductApiService productApiService;
  final AppDatabase appDatabase;

  ProductRepositoryImpl({
    required this.productApiService,
    required this.appDatabase,
  });
  @override
  Future<DataState<ProductResponseEntity>> getAllProduct(
    int skip,
    String? search,
  ) async {
    final result = productApiService.getAllProduct(skip, search);
    return result;
  }

  @override
  Future<List<ProductItemModel>> getSavedProducts() {
    return appDatabase.productDao.getAllProducts();
  }

  @override
  Future<void> saveProduct(ProductItemEntity productItemEntity) async {
    await appDatabase.productDao.insertProduct(
      ProductItemModel.fromEntity(productItemEntity),
    );
  }

  @override
  Future<ProductItemModel?> getProductById(int id) async {
    return await appDatabase.productDao.getProduct(id);
  }

  @override
  Future<void> updateProductFavStatus(int id, int isFavorite) {
    return appDatabase.productDao.updateFavoriteProduct(id, isFavorite);
  }
}
