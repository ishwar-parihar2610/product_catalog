import 'package:product_catalog/core/usecases/usecase.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';

class GetProductByIdUseCase implements Usecase<ProductItemEntity?, int> {
  final ProductRepository _productRespository;

  GetProductByIdUseCase(this._productRespository);

  @override
  Future<ProductItemEntity?> call(int params) async {
    return await _productRespository.getProductById(params).then((value) {
      return value;
    });
  }
}
