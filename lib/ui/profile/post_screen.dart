import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sample/ui/profile/api/post_api.dart';
import 'package:sample/ui/profile/model/post.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'マイページ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  FutureBuilder<List<Post>> _buildBody(
    BuildContext context,
  ) {
    final PostApi client = PostApi(
      Dio(
        BaseOptions(
            contentType: "application/json",
            baseUrl: 'https://jsonplaceholder.typicode.com'),
      ),
    );

    return FutureBuilder<List<Post>>(
      future: client.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Post> posts = snapshot.data ?? <Post>[];
          return _buildPosts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final Post item = posts[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            item.title ?? '',
          ),
        );
      },
    );
  }
}
