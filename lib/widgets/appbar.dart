import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gram/utilities/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset("ig.svg"),
      centerTitle: false,
      backgroundColor: primaryColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_box_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
        ),
        Transform.rotate(
            angle: -math.pi / 4,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send_outlined),
            )),
      ],
    );
  }
}
