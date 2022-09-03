import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gram/models/posts.dart';
import 'package:gram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Method for uploading Posts

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage
  )async{
    String result = "some error occured";
    try {
      String photoUrl = await StorageMethods().uploadImageToFirebase("posts", file, true);

      String postId = const Uuid().v1();


      Post post = Post(description: description, uid: uid, postId: postId, username: username, datePublished: DateTime.now(), postUrl: photoUrl, profImage: profImage, likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      result = "success";

    }
    catch (error){
      result = error.toString();
    }
    return result;
  }
}