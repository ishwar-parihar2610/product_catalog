import 'package:flutter/cupertino.dart';
import 'package:product_catalog/config/routes/app_routes.dart';
import 'package:product_catalog/features/product/presentation/pages/product_details.dart';
import 'package:product_catalog/features/product/presentation/pages/product_listing.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productListing:
        return CupertinoPageRoute(
          builder: (_) => const ProductListing(),
          settings: settings,
        );
      case AppRoutes.productDetails:
        return CupertinoPageRoute(
          builder: (_) => const ProductDetailsPage(),
          settings: settings,
        );
      default:
        return CupertinoPageRoute(builder: (_) => const ProductListing());
    }
  }
}
