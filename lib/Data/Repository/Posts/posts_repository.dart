

import '../../Models/comment_model.dart';
import '../../Models/post_model.dart';
import '../../Web Services/Posts/posts_webservices.dart';

class PostsRepository {
  final PostsWebServices postsWebServices;

  PostsRepository(this.postsWebServices);

  Future<List<PostModel>> getPosts(String groupId) async {
    return await postsWebServices.getPosts(groupId);
  }

  Future<void> addPost(PostModel postModel, String groupId) async {
    return await postsWebServices.addPost(postModel, groupId);
  }

  Future<void> deletePost(String groupId, String postId) async {
    return await postsWebServices.deletePost(groupId, postId);
  }

  Future<void> addComment(String groupId, String postId, CommentModel commentModel) async {
    return await postsWebServices.addComment(groupId, postId, commentModel);
  }

  Future<List<CommentModel>> getComments(String groupId, String postId) async {
    return await postsWebServices.getComments(groupId, postId);
  }

  Future<void> deleteComment(String groupId, String postId, String commentId) async {
    return await postsWebServices.deleteComment(groupId, postId, commentId);
  }

}