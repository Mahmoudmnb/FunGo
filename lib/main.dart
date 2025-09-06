// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fun_go_app/injection.dart';

import 'core/providers/auth_provider.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const ProviderScope(child: FungoApp()));
}

class FungoApp extends ConsumerWidget {
  const FungoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FunGO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Tajawal', // 🔤 خط عربي مرتب
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: authState.when(
        loading: () => const SplashPage(), // ⏳ السبلاش
        unauthenticated: () => const LoginPage(), // 🔑 أول مرة
        authenticated: () => const HomePage(), // 🏠 مسجل مسبقاً
      ),
    );
  }
}
