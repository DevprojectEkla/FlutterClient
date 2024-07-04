import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/background_container.dart';
import '../widgets/customAppBar.dart';
import '../widgets/fractional_textField.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  SignupFormState createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void subscribeUser(BuildContext context) async {
    final url = Uri.parse('http://localhost:8000/api/subscribe/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'last_name': lastNameController.text,
          'first_name': firstNameController.text,
          'username': usernameController.text,
          'email': emailController.text,
          'password1': passwordController.text,
          'password2': confirmPasswordController.text,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subscription Successful'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Subscription Failed: ${response.body}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: 'Subscribe'),
        body: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: (KeyEvent event) {
            if (event.runtimeType == KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.enter) {
                subscribeUser(context);
              }
            }
          },
          child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FractionalWidthTextField(
                  controller: lastNameController,
                  labelText: 'Last Name',
                  errorMessage: 'Please enter your last name'
                  ),
                  FractionalWidthTextField(controller: firstNameController,
                  labelText: 'First Name',
                  errorMessage: 'Please enter your first name'
                  ),
                  FractionalWidthTextField(controller: usernameController,
                  labelText: 'Username',
                  errorMessage: 'Please enter your username'
                  ), 
                  FractionalWidthTextField(controller: emailController,
                  labelText: 'Email',
                  errorMessage: 'Please enter your email'
                  ), 
                  FractionalWidthTextField(controller: passwordController,
                  labelText: 'Password',
                  errorMessage: 'Please enter a password', obscureText: true,
                  ), 
                  FractionalWidthTextField(controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  errorMessage: 'Please confirm your password', obscureText: true,
                  ), 
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        subscribeUser(context);
                      }
                    },
                    child: const Text('Subscribe'),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}
