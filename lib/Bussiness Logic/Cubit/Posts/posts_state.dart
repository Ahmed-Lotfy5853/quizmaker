part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsLoaded extends PostsState {
  final List<PostModel> posts;
  PostsLoaded(this.posts);
}

final class PostAdded extends PostsState {}

final class PostsError extends PostsState {
  final String error;
  PostsError(this.error);
}

final class CommentsLoaded extends PostsState {
  final List<CommentModel> comments;
  CommentsLoaded(this.comments);
}

final class CommentsError extends PostsState {
  final String error;
  CommentsError(this.error);
}

final class CommentsLoading extends PostsState {}


