// Project: product_catalog
// Created Date: 2025-05-10
// Developer: Ishwar Parihar

import 'package:flutter/material.dart';
import 'package:product_catalog/config/routes/router.dart';
import 'package:product_catalog/config/theme/app_theme.dart';
import 'package:product_catalog/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializedDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      // initialRoute: AppRoutes.productListing,
    );
  }
}
