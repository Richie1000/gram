import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gram/utilities/colors.dart';

import '../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailContrller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailContrller.dispose;
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(child: Container(), flex: 2),
          //svg Image
          SvgPicture.asset(
            'assets/ig.svg',
            color: Theme.of(context).primaryColor,
            height: 64,
          ),
          SizedBox(
            height: 64,
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
          InkWell(
            onTap: (){},
          child: Container(
            child: const Text("Log in"),
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: blueColor),
          ),),
          const SizedBox(
            height: 12,
          ),
          Expanded(child: Container(), flex: 2),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: const Text("Dont have an account?"),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            InkWell (
              child: Container(
              child: const Text(
                "Sign up",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            )),
          ])
        ]),
      ),
    ));
  }
}
