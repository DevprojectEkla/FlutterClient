import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;

  String? get accessToken => _accessToken;

  Future<void> setToken(String token) async {
    _accessToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    notifyListeners();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    notifyListeners();
  }

  Future<void> clearToken() async {
    _accessToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    notifyListeners();
  }

  bool isAuthenticated() {
    return _accessToken != null;
  }
}

