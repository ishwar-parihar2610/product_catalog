class ProductResponseEntity {
  int? total;
  int? skip;
  int? limit;
  List<ProductItemEntity>? products;

  ProductResponseEntity({this.total, this.skip, this.limit, this.products});

  ProductResponseEntity copyWith({
    int? total,
    int? skip,
    int? limit,
    List<ProductItemEntity>? products,
  }) {
    return ProductResponseEntity(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      products: products ?? this.products,
    );
  }
}

class ProductItemEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? tags;
  final String? brand;
  final String? sku;
  final double? weight;

  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final String? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;

  final String? images;
  final String? thumbnail;
  int? isFavorite;

  ProductItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,

    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,

    required this.images,
    required this.thumbnail,
    required this.isFavorite,
  });
}

class ReviewEntity {
  final double? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
}
