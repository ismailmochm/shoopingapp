import 'package:flutter/material.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/product_page.dart';

class AppRoutes {
  static const splash = '/';
  static const product = '/product';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );

      case product:
        return MaterialPageRoute(
          builder: (_) => const ProductPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found', style: TextStyle(fontSize: 16)),
            ),
          ),
        );
    }
  }
}
