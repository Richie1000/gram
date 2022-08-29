import 'package:flutter/material.dart';

import '../utilities/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreen;
  const ResponsiveLayout({Key? key, required this.mobileScreen, required this.webScreenLayout}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if (constraints.maxHeight < webScreenSize){
          return webScreenLayout;
        }
        return mobileScreen;
      },
    );
  }
}