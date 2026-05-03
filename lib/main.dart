import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hrm/core/theme/app_theme.dart';
import 'package:hrm/config/routes/app_router.dart';
import 'package:hrm/config/injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  ));

  // Setup DI
  await setupInjection();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  runApp(const HRMApp());
}

class HRMApp extends StatelessWidget {
  const HRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Default to light, can be dynamic later
      routerConfig: AppRouter.router,
    );
  }
}
