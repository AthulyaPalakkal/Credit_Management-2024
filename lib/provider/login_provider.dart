import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/functions.dart';
import '../constants/my_colors.dart';
import '../otp_screen.dart';
import 'main_provider.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String VerificationId = '';
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool loader = false;

  /// send otp to user

  void sendOtp(BuildContext context) async {
    loader = true;
    notifyListeners();
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.transparent,
          content: Text(
            "Verification Completed",
            style: TextStyle(
                fontSize: 16, fontFamily: 'Amikosemi', color: clwhite),
          ),
          duration: Duration(milliseconds: 3000),
        ));
        if (kDebugMode) {}
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.transparent,
            content: Text(
              "Sorry, Verification Failed",
              style: TextStyle(
                  fontSize: 15, fontFamily: 'Amikosemi', color: clwhite),
            ),
            duration: Duration(milliseconds: 3000),
          ));
          if (kDebugMode) {}
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        VerificationId = verificationId;
        loader = false;

        clear();
        notifyListeners();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.transparent,
          content: Text(
            "OTP sent to phone successfully",
            style: TextStyle(
                fontSize: 16, fontFamily: 'Amikosemi', color: clwhite),
          ),
          duration: Duration(milliseconds: 3000),
        ));
        phoneController.clear();
        // print
        log("Verification Id : $verificationId");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  /// verify the Otp code and Login

  void verify(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationId, smsCode: otpController.text);
    print(credential.toString() + "sjjss");
    await auth.signInWithCredential(credential).then((value) {
      final user = value.user;

    });
  }




  void clear() {
    phoneController.clear();
    otpController.clear();
    notifyListeners();
  }
}
