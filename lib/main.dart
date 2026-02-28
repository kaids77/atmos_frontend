import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const AtmosApp());
}

class AtmosApp extends StatelessWidget {
  const AtmosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      builder: (context, child) {
        final data = MediaQuery.of(context);
        return MediaQuery(
          // Fix for "ViewInsets cannot be negative" assertion failure on Flutter Web
          data: data.copyWith(
            viewInsets: data.viewInsets.copyWith(
              bottom: data.viewInsets.bottom.clamp(0.0, double.infinity),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
