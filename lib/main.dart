import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/posts_list.dart';
import 'screens/subscribe.dart'; // Ensure this is the correct path to your SignupForm file
import 'widgets/background_container.dart';
import 'widgets/customAppBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Blog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BlogPage(title: 'My Blog Tech'),
      routes: {
        '/posts_list': (context) => PostsListScreen(),
        '/login': (context) => LoginScreen(),
        '/subscribe': (context) => SignupForm(),
      },
    );
  }
}



class BlogPage extends StatelessWidget {
  final String title;

  const BlogPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
          backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
        title: ' My Blog Tech'
            ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login Section',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/subscribe');
                      },
                      child: Text(
                        'Subscribe',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/posts_list');
          },
          tooltip: 'View Posts',
          child: Icon(Icons.list),
        ),
      ),
    );
  }
}

