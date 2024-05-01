import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data/Models/comment_model.dart';
import '../../../Data/Models/post_model.dart';
import '../../../Data/Repository/Posts/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository postsRepository;
  PostsCubit(this.postsRepository) : super(PostsInitial());

  Future<void> getPosts(String groupId) async {
    emit(PostsLoading());
    try {
      List<PostModel> posts = await postsRepository.getPosts(groupId);
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> addPost(PostModel postModel, String groupId) async {
    emit(PostsLoading());
    try {
      await postsRepository.addPost(postModel, groupId);
      emit(PostAdded());
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> deletePost(String groupId, String postId) async {
    emit(PostsLoading());
    try {
      await postsRepository.deletePost(groupId, postId);
      emit(PostsInitial());
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
