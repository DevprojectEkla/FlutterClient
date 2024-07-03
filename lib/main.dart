import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';
import 'screens/posts_list.dart';
import 'screens/home.dart';
import 'screens/subscribe.dart'; 
import 'widgets/background_container.dart';
import 'widgets/customAppBar.dart';

import 'services/stateProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadToken()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Blog',
      initialRoute: '/',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      ),
      home: const PortalPage(title: 'My Blog Tech'),

      routes: {
        '/home': (context) => HomePage(),
        '/posts_list': (context) => PostsListScreen(),
        '/login': (context) => LoginScreen(),
        '/subscribe': (context) => SignupForm(),
      },
    );
  }
}

class PortalPage extends StatelessWidget {
  final String title;

  const PortalPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select((AuthProvider auth) => auth.accessToken != null);

    Future<void> navigateToNextScreen() async {
      if (isAuthenticated) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToNextScreen();
    });

    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: ' My Blog Tech',
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
                      'Blog Portal',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: navigateToNextScreen, 
                      child: Text('Enter in my World'),
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
              ),
    );
  }
}

