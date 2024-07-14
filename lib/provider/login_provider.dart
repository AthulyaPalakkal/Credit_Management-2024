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
      if (value.user != null) {
        userAuthorized(user?.phoneNumber, context);
      } else {
        if (kDebugMode) {}
      }

    });
  }
  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    String loginUsername = '';
    String userId = '';
    String loginPhoto = "";
    String shopname = "";
    String shoplogo = "";
    String loginPhone = "";
    String loginUserId = "";
    String address = "";
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    try {
      var phone = phoneNumber!;
      print(phoneNumber.toString() + "duudud");
      db.collection("OWNER_DETAILS").where("PHONE_NUMBER", isEqualTo: phone).get().then((value) {
        if (value.docs.isNotEmpty) {
          print("fiifuif");
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            loginUsername = map['OWNER_NAME'].toString();
            loginPhone = map["PHONE_NUMBER"].toString();
            loginPhoto= map["PHOTO"].toString();
            shopname= map["SHOP_NAME"].toString();
            shoplogo= map["LOGO"].toString();
            loginUserId = element.id;
            // userId = map["USER_ID"].toString();
            notifyListeners();

            print("cb bcb");
            callNextReplacement(context,  HomeScreen(name: loginUsername, phone: loginPhone,  userId: loginUserId ,
              photo: loginPhoto, shopname: shopname, shoplogo: shoplogo,));
          }
        } else {
          const snackBar = SnackBar(
              backgroundColor: Colors.transparent,
              duration: Duration(milliseconds: 3000),
              content: Text(
                "Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Amikosemi', color: clwhite),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {
      const snackBar = SnackBar(
          backgroundColor: Colors.transparent,
          duration: Duration(milliseconds: 3000),
          content: Text(
            "Sorry , Some Error Occurred",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                fontSize: 15, fontFamily: 'Amikosemi', color: clwhite),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }





  void clear() {
    phoneController.clear();
    otpController.clear();
    notifyListeners();
  }

}
