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
  bool isAuthenticated = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final session = supabase.auth.currentSession;
    setState(() {
      isAuthenticated = session != null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            final AuthChangeEvent? event = data?.event;
            if (event == AuthChangeEvent.signedIn) {
              return HomePage();
            } else if (event == AuthChangeEvent.signedOut) {
              return const LoginScreen();
            }
          }
          return isAuthenticated ? HomePage() : const LoginScreen();
        },
      ),
    );
  }
}
