import 'dart:async';

import 'package:floor/floor.dart';
import 'package:product_catalog/features/product/data/data_sources/local/product_dao.dart';
import 'package:product_catalog/features/product/data/models/product.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ProductItemModel])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
}
