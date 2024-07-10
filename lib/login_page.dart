import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/provider/login_provider.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:credit_management/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';
import 'home_screen.dart';
import 'otp_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: clwhite,
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(gradient:
          LinearGradient(
            colors: [Color(0xff005e75), Color(0xffc2c2b7), Color(0xff8fa7bd)],
            stops: [0, 1, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Login ",
                  style: GoogleFonts.poppins(
                    letterSpacing: 1.5,
                      fontSize: 26, fontWeight: FontWeight.bold, color: clwhite),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(width: width/1.3,
                child: Consumer<LoginProvider>(
                  builder: (context,value,child) {
                    return TextFormField(
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: clblack,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: value.phoneController,
                      decoration: const InputDecoration(
                        focusColor: Colors.black38,
                        label: Text(
                          "Phone",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: clwhite,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: clwhite),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: clwhite),
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: height/6),
              Consumer<LoginProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: (){
                      if (value.phoneController.text.length == 10 &&
                          value.phoneController.text != '') {
                        db
                            .collection("USERS")
                            .where("PHONE_NUMBER",
                            isEqualTo:
                            "+91${value.phoneController.text}")
                            .get()
                            .then((value) {
                          if (value.docs.isNotEmpty) {
                            loginProvider.sendOtp(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.transparent,
                              content: Text(
                                "Sorry you don't have access",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'AmikoRegular',
                                  fontWeight: FontWeight.normal,
                                  color: clwhite,
                                ),
                              ),
                            ));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.transparent,
                          content: Text(
                            "Enter Valid PhoneNumber",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'AmikoRegular',
                              fontWeight: FontWeight.normal,
                              color: clwhite,
                            ),
                          ),
                        ));
                      }
                    },child:value.loader

                   ? const Center(
                      child: CircularProgressIndicator(
                        color: clwhite,
                      ))
                      : Container(
                      width: width / 1.3,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: cl3005e75

                      ),
                      child:  Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              letterSpacing: 1.5,
                              color: clwhite),
                        ),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: height/18,),

              Consumer<MainProvider>(
                builder: (context, value, child) {
                  return TextButton(
                      onPressed: () {
                        value.clearcustomerdata();
                        callNext(context, Registration());
                      },
                      child:  Text(
                        "Don't have an account? Register!",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.5,
                          color: cl3005e75,
                        ),
                      ));
                }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
