import 'package:bloc_cubit_flutter_demo/cubit/post_cubit.dart';
import 'package:bloc_cubit_flutter_demo/cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostError) {
            Center(child: Text(state.errorMsg));
          } else if (state is PostSuccess) {
            final posts = state.posts;
            return ListView.builder(
              padding: EdgeInsets.all(10),

              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts.elementAt(index);
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text('${post.title}'),
                    subtitle: Text('${post.body}'),
                    trailing: Text('${post.userId} - ${post.id}'),
                  ),
                );
              },
            );
          }
          return Center(child: Text('Unknown State'));
        },
      ),
    );
  }
}
