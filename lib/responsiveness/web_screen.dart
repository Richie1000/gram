import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities/colors.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/ig.svg",
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.message_outlined))
        ],
      ),
      body: Center(
        child: Text("This is Web"),
      ),
    );
  }
}
