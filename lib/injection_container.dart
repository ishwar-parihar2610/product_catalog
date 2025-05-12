import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:product_catalog/features/product/data/data_sources/app_database.dart';
import 'package:product_catalog/features/product/data/data_sources/remote/product_api_service.dart';
import 'package:product_catalog/features/product/data/data_sources/remote/product_api_service_impl.dart';
import 'package:product_catalog/features/product/data/repository/product_repository_impl.dart';
import 'package:product_catalog/features/product/domain/repository/product_repository.dart';
import 'package:product_catalog/features/product/domain/usecases/get_product_by_id.dart';
import 'package:product_catalog/features/product/domain/usecases/get_saved_product_use_case.dart';
import 'package:product_catalog/features/product/domain/usecases/product_use_case.dart';
import 'package:product_catalog/features/product/domain/usecases/save_product_use_case.dart';
import 'package:product_catalog/features/product/domain/usecases/update_fav_use_case.dart';
import 'package:product_catalog/features/product/presentation/controller/product_controller.dart';

final s1 = GetIt.instance;

Future<void> initializedDependency() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('product_catalog.db').build();
  s1.registerSingleton<AppDatabase>(database);

  s1.registerSingleton<Dio>(Dio());
  s1.registerSingleton<ProductApiService>(ProductApiServiceImpl(dio: s1()));
  s1.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(productApiService: s1(), appDatabase: s1()),
  );
  s1.registerSingleton<GetProductUseCase>(GetProductUseCase(s1()));
  s1.registerSingleton<SaveProductUseCase>(SaveProductUseCase(s1()));
  s1.registerSingleton<GetSavedProductUseCase>(GetSavedProductUseCase(s1()));
  s1.registerSingleton<GetProductByIdUseCase>(GetProductByIdUseCase(s1()));
  s1.registerSingleton<UpdateFavUseCase>(UpdateFavUseCase(s1()));

  Get.lazyPut<ProductController>(
    () => ProductController(s1(), s1(), s1(), s1(), s1()),
  );
}
