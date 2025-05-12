import 'package:product_catalog/core/usecases/usecase.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';

class SaveProductUseCase implements Usecase<void, ProductItemEntity> {
  final ProductRepository _productRespository;

  SaveProductUseCase(this._productRespository);

  @override
  Future<void> call(ProductItemEntity params) {
    return _productRespository.saveProduct(params);
  }
}
