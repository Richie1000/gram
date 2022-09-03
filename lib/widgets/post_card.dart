import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage("assets/defaultPic.jpg"),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Username",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //showDialog(context: context, builder: builder)
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ))
      ]),
    );
  }
}
