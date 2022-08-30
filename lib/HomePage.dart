import 'package:doc_home/Constants.dart';
import 'package:doc_home/DashBoard.dart';
import 'package:doc_home/Login.dart';
import 'package:doc_home/SignUp.dart';
import 'package:doc_home/Widgets/customButton.dart';
import 'package:doc_home/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'OnBoardingScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    bool firstTimeState = box.get('introduction') ?? true;

    return firstTimeState
        ? const OnBoardingScreen()
        : Scaffold(
            body: SafeArea(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/HomePageBackground.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUp());
                        },
                        child: CustomButton(
                            buttonText: 'Create Account',
                            buttonHeight: 60,
                            buttonWidth: 200),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Login());
                        },
                        child: CustomButton(
                            buttonText: 'Login',
                            buttonHeight: 60,
                            buttonWidth: 200),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
