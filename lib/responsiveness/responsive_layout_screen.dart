import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/global_variables.dart';
import '../providers/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreen;
  const ResponsiveLayout(
      {Key? key, required this.mobileScreen, required this.webScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    Userprovider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < webScreenSize) {
          return widget.webScreenLayout;
        }
        return widget.mobileScreen;
      },
    );
  }
}
