import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/screens/utility/texts.dart';

import '../screens/utility/buttons.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'emailid@gmail.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _email = value!;
                },
              ),
              hbox(20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  _password = value;
                  return null;
                },
                onSaved: (String? value) {
                  _password = value!;
                },
              ),
              hbox(20.0),
              TextButton(
                onPressed: _submitForm,
                style: buttonStyle(Colors.blue),
                child: textwidget(context, 'Login'),
              ),
              hbox(10.0),
              TextButton(
                onPressed: () {
                  Get.offAndToNamed('/sign_up');
                },
                style: buttonStyle(Colors.grey[800]),
                child: textwidget(context, 'Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    AuthService authService = AuthService();
    final response = await authService.signIn(_email, _password);

    if (response == 'success') {
      _showSnackBar('Logged in successfully', Colors.green);
    } else {
      _showSnackBar('Login was unsuccessful due to $response', Colors.red);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: textwidget(context, message),
        backgroundColor: backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10.0),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
