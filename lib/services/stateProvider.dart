import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  bool _isLoading = true;

  String? get accessToken => _accessToken;
  bool get isLoading => _isLoading;

  Future<void> setToken(String token) async {
    _accessToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadToken() async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearToken() async {
    _accessToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    notifyListeners();
  }

  Future<void> logout() async {
    _accessToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    notifyListeners();
  }

  bool isAuthenticated() {
    return _accessToken != null && _accessToken!.isNotEmpty;
  }
}
