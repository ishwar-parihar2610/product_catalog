import 'package:product_catalog/core/resources/data_state.dart';
import 'package:product_catalog/core/usecases/usecase.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';

class GetProductUseCase
    implements Usecase<DataState<ProductResponseEntity>, Map<String, dynamic>> {
  final ProductRepository _productRespository;

  GetProductUseCase(this._productRespository);

  @override
  Future<DataState<ProductResponseEntity>> call(
    Map<String, dynamic> params,
  ) async {
    return _productRespository.getAllProduct(params['skip'], params['search']);
  }
}
