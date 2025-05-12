import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_catalog/features/product/domain/entities/product.dart';
import 'package:product_catalog/features/product/presentation/widgets/custom_rating_view.dart';

/// {@template product_review}
/// ProductReview widget.
/// {@endtemplate}
class ProductReview extends StatelessWidget {
  final ReviewEntity reviewEntity;
  const ProductReview({
    super.key,
    required this.reviewEntity,
    // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Container(
    // height: 70,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,

      border: Border.all(
        color: const Color.fromARGB(255, 221, 221, 221),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 221, 221, 221),
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reviewEntity.reviewerName ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Text(
              DateFormat(
                'dd MMM yyyy',
              ).format(reviewEntity.date ?? DateTime.now()),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
        Text(
          reviewEntity.reviewerEmail ?? '',
          style: const TextStyle(fontSize: 10, color: Colors.black),
        ),
        CustomRatingView(rating: (reviewEntity.rating ?? 0).toInt()),
        Text(
          reviewEntity.comment ?? '',
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    ),
  );
}
