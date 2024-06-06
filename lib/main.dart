import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:time_capsule_app/auth/login.dart';
import 'package:time_capsule_app/auth/sign_up.dart';
import 'package:time_capsule_app/screens/create_time_capsule.dart';
import 'package:time_capsule_app/screens/homepage.dart';
import 'package:time_capsule_app/screens/wrapper.dart';

import 'screens/theme/theme_notifier.dart';

Future<void> main() async {
  // final supabaseUrl = dotenv.env['SUPABASE_URL']!;
  // final supabaseKey = dotenv.env['SUPABASE_ANON_KEY']!;
  const supabaseUrl = 'https://lnpdbtwmdahlmxnxrgws.supabase.co';
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxucGRidHdtZGFobG14bnhyZ3dzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY3MDYwMzYsImV4cCI6MjAzMjI4MjAzNn0.EBQzo5R1g0ckjejRUi1xzwtQqFMruWEnP4kb2LcK32w';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: themeNotifier.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
            '/home_page': (context) => HomePage(),
            '/create_screen': (context) => CreateScreen(),
            '/sign_up': (context) => const SignUpScreen(),
            '/login': (context) => const LoginScreen(),
          },
        );
      },
    );
  }
}
