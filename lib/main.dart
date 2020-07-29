import 'package:bloc_test/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BlocProvider(
      create: (BuildContext context) {
        PostBloc();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BLOC Test'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          PostBloc()..add(FetchPosts());
        }),
        body: BlocProvider(
          create: (context) => PostBloc()..add(FetchPosts()),
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;
  @override
  void initState() {
    _postBloc = BlocProvider.of<PostBloc>(context);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(FetchPosts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostInitial) {
        print('IN INIT');
        return Center(child: CircularProgressIndicator());
      }
      if (state is PostFaliure) {
        print('IN FAIL');

        return Center(
          child: Text('Failed to fetch posts'),
        );
      }
      if (state is PostSuccess) {
        print('IN Success');
        if (state.posts.isEmpty) {
          return Center(
            child: Text('NO POSTS AVAILABLE'),
          );
        }
        return ListView.builder(
          // itemCount: state.posts.length,
          itemCount: state.hasReachedMaxLimit
              ? state.posts.length
              : state.posts.length + 1,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return index >= state.posts.length
                ? BottomLoader()
                : ListTile(
                    title: Text(state.posts[index].title),
                  );
          },
        );
      }
    });
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
