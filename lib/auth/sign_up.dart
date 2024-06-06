import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/screens/utility/texts.dart';

import '../screens/utility/buttons.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  DateTime? _dob;
  String _password = '';
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                  labelText: 'Name',
                  hintText: 'Shrutika Hilale',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _name = value!;
                },
              ),
              hbox(20.0),
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
              InkWell(
                onTap: () => _pickDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: Icon(Icons.date_range),
                  ),
                  child: Text(
                    _dob == null
                        ? 'No date selected'
                        : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
                  ),
                ),
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_confirmPasswordVisible,
                validator: (String? value) {
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (String? value) {},
              ),
              hbox(20.0),
              TextButton(
                onPressed: _submitForm,
                style: buttonStyle(Colors.blue),
                child: textwidget(context, 'Register Now'),
              ),
              hbox(10.0),
              TextButton(
                onPressed: () {
                  Get.offAndToNamed('/login');
                },
                style: buttonStyle(Colors.grey[800]),
                child: textwidget(context, 'Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dob,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _dob) {
      setState(() {
        _dob = pickedDate;
      });
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    AuthService authService = AuthService();
    await authService.signUp(_email, _password, _name, _dob!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: textwidget(context, 'User registered successfully'),
        backgroundColor: Colors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10.0),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
