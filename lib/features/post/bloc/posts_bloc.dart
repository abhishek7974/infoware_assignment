import 'dart:async';
import 'dart:developer';

import 'package:assignment/features/post/model/data_model.dart';
import 'package:assignment/features/post/repo/post_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostInitialFetchEvent>(postInitialfetchEvent);
  }

  FutureOr<void> postInitialfetchEvent(
      PostInitialFetchEvent event, Emitter<PostsState> emit)async {

    emit(PostFetchingLoadingState());
     try{
       List<DataModel> postDataList = await PostsRepo.fetchPostData();
       emit(PostFetchingSuccessfulState(posts: postDataList));
     }
     catch(e){
       emit(PostFetchingErrorState(message: e.toString()));
       log(" error === ${e.toString()}");
     }

  }
}


