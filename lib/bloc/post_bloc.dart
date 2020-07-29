import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/models/post.dart';
import 'package:bloc_test/services/apiServices.dart';
import 'package:equatable/equatable.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());
  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    List<Posts> postsList = [];
    final currentState = state;
    if (event is FetchPosts && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          print('in here');
          final result = await ApiServices().getPosts(0, 20);
          print('1');
          result.forEach((post) {
            postsList.add(Posts.fromJson(post));
          });

          print('2');
          print('POST LIST=====>$postsList');

          yield PostSuccess(posts: postsList, hasReachedMaxLimit: false);
        }
        if (currentState is PostSuccess) {
          print('IN SUCCESS');
          final result =
              await ApiServices().getPosts(currentState.posts.length, 20);
          result.forEach(
            (post) => postsList.add(
              Posts.fromJson(post),
            ),
          );
          yield PostSuccess(
              posts: currentState.posts + postsList, hasReachedMaxLimit: false);
        }
      } catch (e) {
        print('in catch====>${e.toString()}');
        yield PostFaliure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMaxLimit;
}
