import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<List<Post>> fetchPosts(String? accessToken) async {
    final response = await http.get(Uri.parse('$baseUrl/posts'), headers: {
      'Authorization':
          'Bearer ${accessToken ?? ""}', // Handle nullable accessToken
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
}
