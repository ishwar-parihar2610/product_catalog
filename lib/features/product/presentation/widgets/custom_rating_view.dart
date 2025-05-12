import 'package:flutter/material.dart';

/// {@template custom_rating_view}
/// CustomRatingView widget.
/// {@endtemplate}
class CustomRatingView extends StatelessWidget {
  final int rating;

  /// {@macro custom_rating_view}
  const CustomRatingView({
    super.key,
    required this.rating,
    // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Row(
    spacing: 2,
    children: [
      ...List.generate(5, (index) {
        return Icon(index < rating ? Icons.star : Icons.star_border, size: 12);
      }),
      Text(
        "Rating : $rating",
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    ],
  );
}
