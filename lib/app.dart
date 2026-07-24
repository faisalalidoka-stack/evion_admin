import 'package:flutter/material.dart';

import 'core/config/app_router.dart';
import '/core/theme/app_theme.dart';

class EvionAdminApp extends StatelessWidget {
  const EvionAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EViON Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
