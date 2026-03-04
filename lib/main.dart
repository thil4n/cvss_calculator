import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cvss_calculator/core/theme/app_theme.dart';
import 'package:cvss_calculator/features/cvss/presentation/pages/cvss_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const CvssApp());
}

class CvssApp extends StatelessWidget {
  const CvssApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVSS v3.1 Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const CvssPage(),
    );
  }
}
