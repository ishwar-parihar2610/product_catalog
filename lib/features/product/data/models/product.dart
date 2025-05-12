import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';

class ProductResponse extends ProductResponseEntity {
  ProductResponse({
    required super.total,
    required super.skip,
    required super.limit,
    required super.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
      products:
          (json['products'] as List)
              .map((product) => ProductItemModel.fromJson(product))
              .toList(),
    );
  }
}

@Entity(tableName: 'product', primaryKeys: ['id'])
class ProductItemModel extends ProductItemEntity {
  ProductItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,

    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,

    required super.images,
    required super.thumbnail,
    required super.isFavorite,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      isFavorite: 0,
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      tags: jsonEncode(json['tags']),
      brand: json['brand'],
      sku: json['sku'],
      weight: (json['weight'] as num).toDouble(),

      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: jsonEncode(json['reviews'] as List<dynamic>?),

      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],

      images: jsonEncode(json['images'] as List<dynamic>?),

      thumbnail: json['thumbnail'],
    );
  }
  factory ProductItemModel.fromEntity(ProductItemEntity entity) {
    return ProductItemModel(
      isFavorite: entity.isFavorite,
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      discountPercentage: entity.discountPercentage,
      rating: entity.rating,
      stock: entity.stock,
      tags: entity.reviews,
      brand: entity.brand,
      sku: entity.sku,
      weight: entity.weight,

      warrantyInformation: entity.warrantyInformation,
      shippingInformation: entity.shippingInformation,
      availabilityStatus: entity.availabilityStatus,
      reviews: entity.reviews,

      returnPolicy: entity.returnPolicy,
      minimumOrderQuantity: entity.minimumOrderQuantity,

      images: entity.images,

      thumbnail: entity.thumbnail,
    );
  }
}

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}
