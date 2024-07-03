import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/background_container.dart';
import '../widgets/customAppBar.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final url = Uri.parse('http://localhost:8000/api/token/'); 

    try {
      final response = await http.post(
        url,
        body: {
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access', data['access']);
        await prefs.setString('refresh', data['refresh']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushNamed(context, '/home'); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Failed'),
            duration: Duration(seconds: 10),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 10),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: 'Login',
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () => loginUser(context),
                  child: Text('Login'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subscribe');
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

