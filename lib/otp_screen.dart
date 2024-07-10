import 'package:credit_management/provider/login_provider.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'constants/my_colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
     backgroundColor: clwhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            SizedBox(height: height/3,),
             Text("Get OTP",style: GoogleFonts.poppins(
                fontSize: 18,
               letterSpacing: 1.5,
               color: cl3005e75,),

            ),
            SizedBox(height:height/16,),
           Consumer<LoginProvider>(
             builder: (context,value,child) {
               return Pinput(
                 controller:value.otpController,

                 length: 6,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         defaultPinTheme: PinTheme( decoration: BoxDecoration(
                color: cl3005e75.withOpacity(0.8),
                border: Border.all(color: clwhite),
                borderRadius: BorderRadius.circular(15),

                         ),
                textStyle: GoogleFonts.poppins(
                    fontSize: 15, color: clwhite),
                height: 50,
                width: 50,

                         ),
                 onCompleted: (pin){
                   value.verify(context);

                 },


                       );
             }
           ),
            SizedBox(height: height/8,),

          ],
        ),
      ),
    );
  }
}
