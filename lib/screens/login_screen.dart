import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/text_field.dart';
import '../utilities/colors.dart';
import '../resources/authentication.dart';
import '../utilities/utils.dart';
import './signup_screen.dart';
import '../responsiveness/responsive_layout_screen.dart';
import '../responsiveness/mobile_screen.dart';
import '../responsiveness/web_screen.dart';

class CustomLoginScreen extends StatefulWidget {
  const CustomLoginScreen({super.key});

  @override
  State<CustomLoginScreen> createState() => _CustomLoginScreenState();
}

class _CustomLoginScreenState extends State<CustomLoginScreen> {
  final TextEditingController _emailContrller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
        email: _emailContrller.text, password: _passwordController.text);

    if (result == "success") {
      print(result);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              mobileScreen: MobileScreen(),
              webScreenLayout: WebScreenLayout())));
    } else {
      showSnackBar(result, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: SvgPicture.asset("assets/ig.svg"),
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                SvgPicture.asset(
                  'assets/ig.svg',
                  color: Colors.white54,
                  height: 64,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    textEditingController: _emailContrller,
                    hintText: "email",
                    textInputType: TextInputType.emailAddress),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Password",
                  textInputType: TextInputType.text,
                  isPassword: true,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: login,
                  child: Container(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Login"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: blueColor),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    child: const Text("Dont have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                    child: Container(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
