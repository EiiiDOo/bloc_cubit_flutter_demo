import 'package:bloc_cubit_flutter_demo/model/post.dart';
import 'package:equatable/equatable.dart';

sealed class PostState extends Equatable {}

class PostLoading extends PostState {
  @override
  List<Object?> get props => [];
}

class PostError extends PostState {
  final String errorMsg;
  PostError(this.errorMsg);
  @override
  List<Object?> get props => [errorMsg];
}

class PostSuccess extends PostState {
  final List<Post> posts;
  PostSuccess(this.posts);
  @override
  List<Object?> get props => [posts];
}
