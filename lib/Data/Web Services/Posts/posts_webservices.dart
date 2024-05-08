

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/comment_model.dart';
import 'package:quiz_maker/Data/Models/post_model.dart';

class PostsWebServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> addPost(PostModel postModel, String groupId ) async {
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(postsCollection).add(postModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>> getPosts(String groupId) async {
    List<PostModel> posts = [];
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(postsCollection).get().then((value) {
        value.docs.forEach((element) {
          posts.add(PostModel.fromMap(element.data()));
        });
      });
      return posts;
    }catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(String groupId, String postId) async {
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(postsCollection).doc(postId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addComment(String groupId, String postId, CommentModel commentModel) async {
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(postsCollection).doc(postId).collection(
          commentsCollection).add(commentModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteComment(String groupId, String postId, String commentId) async {
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(postsCollection).doc(postId).collection(
          commentsCollection).doc(commentId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getComments(String groupId, String postId) async {
    List<CommentModel> comments = [];
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(postsCollection).doc(postId).collection(
          commentsCollection).get().then((value) {
        value.docs.forEach((element) {
          comments.add(CommentModel.fromMap(element.data()));
        });
          });
      return comments;
    } catch (e) {
      rethrow;
    }
  }
}