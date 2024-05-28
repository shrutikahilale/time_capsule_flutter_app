import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/login.dart';
import '../main.dart';
import 'homepage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            final AuthChangeEvent? event = data?.event;
            if (event == AuthChangeEvent.signedIn) {
              return HomePage();
            } else {
              return const LoginScreen();
            }
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
