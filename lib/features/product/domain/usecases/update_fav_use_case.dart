import 'package:product_catalog/core/usecases/usecase.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';

class UpdateFavUseCase implements Usecase<void, Map<String, dynamic>> {
  final ProductRepository _productRespository;

  UpdateFavUseCase(this._productRespository);

  @override
  Future<void> call(Map<String, dynamic> params) async {
    return await _productRespository.updateProductFavStatus(
      params['id'],
      params['isFavorite'],
    );
  }
}
