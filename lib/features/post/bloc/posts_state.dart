part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostActionState extends PostsState{}


 class PostsInitial extends PostsState {}

 class PostFetchingLoadingState extends PostsState {

 }

 class PostFetchingErrorState extends PostsState {
  final String message ;
  PostFetchingErrorState({required this.message});
 }

class PostFetchingSuccessfulState extends PostsState{
  final List<DataModel> posts;

  PostFetchingSuccessfulState({required this.posts});
}
