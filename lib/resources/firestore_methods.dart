import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gram/models/posts.dart';
import 'package:gram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Method for uploading Posts

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String result = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToFirebase("posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      result = "success";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid,
      String username, String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': username,
          'uid': uid,
          'text': text,
          'commerntId': commentId,
          "datepublished": DateTime.now(),
        });
      } else {
        print("Comment is empty");
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> deletePost(String id) async {
    try {
      await _firestore.collection('posts').doc(id).delete();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
