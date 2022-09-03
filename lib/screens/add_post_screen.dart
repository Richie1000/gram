import 'package:flutter/material.dart';
import 'package:gram/utilities/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: IconButton(
    //     icon: const Icon(Icons.upload),
    //     onPressed: () {},
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text("New Post"),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/defaultpic.jpg"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write a Caption...",
                  border: InputBorder.none,
                ),
                maxLines: 8,
              ),
            ),
            SizedBox(
              height: 45,
              width: 45,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/defaultpic.jpg"),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter),
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
