import 'package:assignment/features/post/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_post_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBlocs = PostsBloc();
  @override
  void initState() {
    postsBlocs.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post Page",
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/audio');
          }, icon: Icon(Icons.play_circle)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/form');
          }, icon: Icon(Icons.note))
        ],
      ),
      body: BlocConsumer<PostsBloc, PostsState>(

          bloc: postsBlocs,
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFetchingLoadingState :
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PostFetchingSuccessfulState:
                final successState = state as PostFetchingSuccessfulState;
                return Container(
                  child: ListView.builder(
                      itemCount: successState.posts.length,
                      itemBuilder: (context, item) {
                        final postData = successState.posts[item];
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return PostDetailPage(post: postData,);
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            color: Colors.black12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title :  ${postData.title}"),
                                Text("Body : ${postData.body}"),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              case PostFetchingErrorState:
                final errorState = state as PostFetchingErrorState;
                return Center(
                  child: Text(errorState.message),
                );
              default:
                return Container();
            }

          },
          listener: (context, state) {}
      ),
    );
  }
}
