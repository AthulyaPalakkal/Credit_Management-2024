import 'dart:async';

import 'package:credit_management/login_page.dart';
import 'package:credit_management/provider/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    var loginUser = auth.currentUser;
    Timer( Duration(seconds: 5), () {
      if(loginUser==null){
        callNextReplacement(context, LoginPage());
      }else{
        loginProvider.userAuthorized(loginUser.phoneNumber, context);

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: clwhite,
      body: Center(
        child:
        GradientText(
          text:    "Clear Credit",
          gradient: const  LinearGradient(
            colors: [Color(0xff005e75), Color(0xffc2c2b7), Color(0xff8fa7bd)],
            stops: [0, 1, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          style: TextStyle(
            fontSize: 40,
            fontFamily: "Amikosemi",
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                offset: const Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? style;

  const GradientText({
    Key? key,
    required this.text,
    required this.gradient,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}