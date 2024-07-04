import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/post.dart';
import '../screens/post_detail.dart';
import '../widgets/background_container.dart';
import '../widgets/customAppBar.dart';

class PostsListScreen extends StatefulWidget {
   const PostsListScreen ({super.key});
  @override
  PostsListScreenState createState() => PostsListScreenState();
}

class PostsListScreenState extends State<PostsListScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: 'Posts List'),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: futurePosts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Post post = snapshot.data![index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Text(
                            'by ${post.author.username} on ${post.dateCreated.toLocal()}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetail(post: post),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

