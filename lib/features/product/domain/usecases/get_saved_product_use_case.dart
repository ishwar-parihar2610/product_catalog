import 'package:product_catalog/core/usecases/usecase.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';

class GetSavedProductUseCase
    implements Usecase<List<ProductItemEntity>, void> {
  final ProductRepository _productRespository;

  GetSavedProductUseCase(this._productRespository);

  @override
  Future<List<ProductItemEntity>> call(void params) {
    return _productRespository.getSavedProducts();
  }
}
