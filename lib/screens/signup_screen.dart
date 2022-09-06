import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gram/responsiveness/mobile_screen.dart';
import 'package:gram/responsiveness/responsive_layout_screen.dart';
import 'package:gram/responsiveness/web_screen.dart';
import 'package:gram/utilities/colors.dart';
import 'package:gram/utilities/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/text_field.dart';
import '../resources/authentication.dart';
import '../screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailContrller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailContrller.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void _selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUp(
        email: _emailContrller.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    print(res);

    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              mobileScreen: MobileScreen(),
              webScreenLayout: WebScreenLayout())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Expanded(child: Container(), flex: 2),
                  SizedBox(
                    height: 10,
                  ),
                  //Circular Image

                  //svg Image
                  SvgPicture.asset(
                    'assets/ig.svg',
                    color: Theme.of(context).primaryColor,
                    height: 64,
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              foregroundImage:
                                  AssetImage("assets/defaultpic.jpg"),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: _selectImage,
                          icon: Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 64,
                  ),

                  // Name textField
                  TextFieldInput(
                    hintText: "Username",
                    textInputType: TextInputType.text,
                    textEditingController: _usernameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //e-mail textfield
                  TextFieldInput(
                    hintText: "Enter Your Email",
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailContrller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //password textfield
                  TextFieldInput(
                    hintText: "Password",
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Bio textfield
                  TextFieldInput(
                    hintText: "Enter Bio",
                    textInputType: TextInputType.name,
                    textEditingController: _bioController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: blueColor,
                        )
                      : InkWell(
                          onTap: signUpUser,
                          child: Container(
                            child: const Text("Sign Up"),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: blueColor),
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),

                  GestureDetector(
                      child: Text("Login Instead"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomLoginScreen()));
                      })

                  //Expanded(child: Container(), flex: 2),
                  // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //   Container(
                  //     child: const Text("Dont have an account?"),
                  //     padding: const EdgeInsets.symmetric(vertical: 8),
                  //   ),
                  //   GestureDetector (
                  //     onTap: (){},
                  //     child: Container(
                  //     child: const Text(
                  //       "Sign up",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(vertical: 8),
                  //   ),),
                  // ])
                ]),
          ),
        ),
      ),
    ));
  }
}
