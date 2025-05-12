import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 210,
            ),
            itemBuilder:
                (_, __) => Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 3,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: _skeleton(20, 20, radius: 5),
                      ),
                      _skeleton(80, 100),

                      const SizedBox(height: 8),
                      _skeleton(14, 120),

                      const SizedBox(height: 6),
                      _skeleton(14, 90),
                      const SizedBox(height: 6),
                      _skeleton(14, 35),
                    ],
                  ),
                ),

            // Shimmer.fromColors(
            //   baseColor: Colors.grey[300]!,
            //   highlightColor: Colors.grey[100]!,
            //   child:

            // ),
          ),
        ),
      ],
    );
  }

  _skeleton(double height, double width, {double? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.2),
      direction: ShimmerDirection.ttb,
      child: Container(
        height: height,

        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
      ),
    );
  }
}
