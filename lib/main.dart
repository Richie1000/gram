import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:gram/responsiveness/responsive_layout_screen.dart';
import './utilities/colors.dart';
import './responsiveness/mobile_screen.dart';
import './responsiveness/web_screen.dart';
import './screens/logins_screen.dart';
import './screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gram',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreen: MobileScreen(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: SignUpScreen(),
    );
  }
}
