import 'dart:convert';

import 'package:bloc_cubit_flutter_demo/bloc/post_event.dart';
import 'package:bloc_cubit_flutter_demo/bloc/post_state.dart';
import 'package:bloc_cubit_flutter_demo/model/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class PostCubit extends Bloc<PostEvent, PostState> {
  PostCubit() : super(PostLoading()) {
    on<FetchPostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        final res = await get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        ).timeout(Duration(seconds: 10));

        if (res.statusCode == 200) {
          final List listJson = jsonDecode(res.body);
          final List<Post> listPosts = [];
          for (var element in listJson) {
            listPosts.add(Post.fromJson(element));
          }

          emit(PostSuccess(listPosts));
        } else {
          emit(PostError('Server responded with status: ${res.statusCode}'));
        }
      } catch (e) {
        emit(PostError('ERROR: $e'));
      }
    });
  }
}
