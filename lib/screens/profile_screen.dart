import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gram/resources/authentication.dart';
import 'package:gram/resources/firestore_methods.dart';
import 'package:gram/screens/login_screen.dart';
import 'package:gram/utilities/colors.dart';
import 'package:gram/utilities/utils.dart';
import 'package:gram/widgets/follow_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  var numberPosts;
  var followers;
  var following;
  bool _isFollowing = false;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      numberPosts = postSnap.docs.length;
      //print(postSnap);
      userData = snap.data()!;
      print(numberPosts);
      followers = snap.data()!['followers'].length;
      following = snap.data()!['following'].length;
      _isFollowing = snap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (error) {
      showSnackBar(error.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitDualRing(color: blueColor)
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username']),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(userData['photourl']),
                            radius: 40,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(numberPosts, '  Posts'),
                                    buildStatColumn(followers, '  Followers'),
                                    buildStatColumn(following, '   Following'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            text: 'Logout',
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            borderColor: Colors.grey,
                                            textColor: primaryColor,
                                            function: () async {
                                              AuthMethods().logout();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomLoginScreen()),
                                              );
                                            },
                                          )
                                        : _isFollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                borderColor: Colors.grey,
                                                textColor: Colors.black,
                                                function: () async {
                                                  await FirestoreMethods()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid']);

                                                  setState(() {
                                                    _isFollowing = false;
                                                    followers--;
                                                  });
                                                  //setState(() {});
                                                },
                                              )
                                            : FollowButton(
                                                text: 'follow',
                                                backgroundColor: Colors.blue,
                                                borderColor: Colors.blue,
                                                textColor: Colors.white,
                                                function: () async {
                                                  await FirestoreMethods()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid']);
                                                  //setState(() {});
                                                  setState(() {
                                                    _isFollowing = true;
                                                    followers++;
                                                  });
                                                },
                                              )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(userData['bio']),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snaapshot) {
                      if (snaapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: SpinKitDualRing(color: blueColor),
                        );
                      }

                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: (snaapshot.data! as dynamic).docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 1.5,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snaapshot.data! as dynamic).docs[index];

                            return Container(
                              child: Image(
                                image: NetworkImage(snap['postUrl']),
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                    })
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
