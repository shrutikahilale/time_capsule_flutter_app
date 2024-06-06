import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:time_capsule_app/main.dart';

import 'database_service.dart';

class AuthService {
  String? get currentUserId {
    return supabase.auth.currentUser?.id;
  }

  Future<void> signUp(
      String email, String password, String name, DateTime dob) async {
    final response =
        await supabase.auth.signUp(password: password, email: email);
    if (response.user == null) {
      throw Exception('Unable to register, try after some time');
    } else {
      DatabaseService databaseService = DatabaseService();
      await databaseService.createUser(email, currentUserId!, name, dob);
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return 'success';
    } catch (e) {
      if (e is AuthException) {
        print(e.statusCode);
        if (e.statusCode == '400') {
          return 'invalid-creds';
        }
      } else {
        print('Unexpected error: $e');
      }
    }
    return 'other';
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    final user = supabase.auth.currentUser;
    return user != null;
  }
}
