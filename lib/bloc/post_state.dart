part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostFaliure extends PostState {
  @override
  List<Object> get props => [];
}

class PostSuccess extends PostState {
  final List<Posts> posts;
  final bool hasReachedMaxLimit;
  PostSuccess({this.hasReachedMaxLimit, this.posts});
  PostSuccess copyWith({
    List<Posts> posts,
    bool hasReachedMaxLimit,
  }) {
    return PostSuccess(
      posts: posts ?? this.posts,
      hasReachedMaxLimit: hasReachedMaxLimit ?? this.hasReachedMaxLimit,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMaxLimit];
  @override
  String toString() =>
      'PostSuccess { posts: ${posts.length}, hasReachedMax: $hasReachedMaxLimit }';
}
