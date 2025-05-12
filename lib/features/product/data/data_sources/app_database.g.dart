// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `product` (`id` INTEGER, `title` TEXT, `description` TEXT, `category` TEXT, `price` REAL, `discountPercentage` REAL, `rating` REAL, `stock` INTEGER, `tags` TEXT, `brand` TEXT, `sku` TEXT, `weight` REAL, `warrantyInformation` TEXT, `shippingInformation` TEXT, `availabilityStatus` TEXT, `reviews` TEXT, `returnPolicy` TEXT, `minimumOrderQuantity` INTEGER, `images` TEXT, `thumbnail` TEXT, `isFavorite` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productItemModelInsertionAdapter = InsertionAdapter(
            database,
            'product',
            (ProductItemModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'category': item.category,
                  'price': item.price,
                  'discountPercentage': item.discountPercentage,
                  'rating': item.rating,
                  'stock': item.stock,
                  'tags': item.tags,
                  'brand': item.brand,
                  'sku': item.sku,
                  'weight': item.weight,
                  'warrantyInformation': item.warrantyInformation,
                  'shippingInformation': item.shippingInformation,
                  'availabilityStatus': item.availabilityStatus,
                  'reviews': item.reviews,
                  'returnPolicy': item.returnPolicy,
                  'minimumOrderQuantity': item.minimumOrderQuantity,
                  'images': item.images,
                  'thumbnail': item.thumbnail,
                  'isFavorite': item.isFavorite
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductItemModel> _productItemModelInsertionAdapter;

  @override
  Future<ProductItemModel?> getProduct(int id) async {
    return _queryAdapter.query('SELECT id, title FROM product WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductItemModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            category: row['category'] as String?,
            price: row['price'] as double?,
            discountPercentage: row['discountPercentage'] as double?,
            rating: row['rating'] as double?,
            stock: row['stock'] as int?,
            tags: row['tags'] as String?,
            brand: row['brand'] as String?,
            sku: row['sku'] as String?,
            weight: row['weight'] as double?,
            warrantyInformation: row['warrantyInformation'] as String?,
            shippingInformation: row['shippingInformation'] as String?,
            availabilityStatus: row['availabilityStatus'] as String?,
            reviews: row['reviews'] as String?,
            returnPolicy: row['returnPolicy'] as String?,
            minimumOrderQuantity: row['minimumOrderQuantity'] as int?,
            images: row['images'] as String?,
            thumbnail: row['thumbnail'] as String?,
            isFavorite: row['isFavorite'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<ProductItemModel>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM product',
        mapper: (Map<String, Object?> row) => ProductItemModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            category: row['category'] as String?,
            price: row['price'] as double?,
            discountPercentage: row['discountPercentage'] as double?,
            rating: row['rating'] as double?,
            stock: row['stock'] as int?,
            tags: row['tags'] as String?,
            brand: row['brand'] as String?,
            sku: row['sku'] as String?,
            weight: row['weight'] as double?,
            warrantyInformation: row['warrantyInformation'] as String?,
            shippingInformation: row['shippingInformation'] as String?,
            availabilityStatus: row['availabilityStatus'] as String?,
            reviews: row['reviews'] as String?,
            returnPolicy: row['returnPolicy'] as String?,
            minimumOrderQuantity: row['minimumOrderQuantity'] as int?,
            images: row['images'] as String?,
            thumbnail: row['thumbnail'] as String?,
            isFavorite: row['isFavorite'] as int?));
  }

  @override
  Future<void> updateFavoriteProduct(
    int id,
    int isFavorite,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE product SET isFavorite = ?2 WHERE id = ?1',
        arguments: [id, isFavorite]);
  }

  @override
  Future<void> insertProduct(ProductItemModel product) async {
    await _productItemModelInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }
}
