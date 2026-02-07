import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/constants/app_constants.dart';
import 'package:prayer_app/core/services/local_storage_service.dart';
import 'package:prayer_app/core/theme/app_theme.dart';
import 'package:prayer_app/core/utils/logger.dart';
import 'package:prayer_app/features/home/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await LocalStorageService.init();
    Logger.info('App initialized successfully');
  } catch (e, stackTrace) {
    Logger.error('Failed to initialize app', e, stackTrace);
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
