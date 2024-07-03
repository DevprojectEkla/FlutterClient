import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/background_container.dart';
import '../widgets/customAppBar.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  const PostDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: post.title,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center( 
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        post.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        'by ${post.author.username} on ${post.dateCreated.toLocal()}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      post.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),),
          ),
        ),
      ),
    );
  }
}

