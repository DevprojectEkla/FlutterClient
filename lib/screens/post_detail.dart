import 'package:flutter/material.dart';
import '../models/post.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  const PostDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.0),
            Text('by ${post.author.username} on ${post.dateCreated.toLocal()}'),
            SizedBox(height: 16.0),
            Text(post.content),
          ],
        ),
      ),
    );
  }
}

