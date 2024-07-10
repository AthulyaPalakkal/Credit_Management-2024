import 'package:credit_management/provider/main_provider.dart';
import 'package:credit_management/shopowner_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';
import 'crediters_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context,listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: clwhite,
      appBar: AppBar(
        backgroundColor: cl3005e75,
        toolbarHeight: 100,
        leading: InkWell(
          onTap: ()
          {
            callNext(context, ShopownerProfile());
          },
          child: const CircleAvatar(
            radius: 12,
            backgroundColor: clwhite,
          ),
        ),
        title: Text("Shop name",style: GoogleFonts.poppins(
          fontSize: 22,fontWeight:FontWeight.w500,
          color: clwhite,letterSpacing: 1.5
        ),),
        centerTitle: true,
      ),

      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Container(
              width: width,
              height: height/6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff005e75), Color(0xffc2c2b7), Color(0xff8fa7bd)],
                  stops: [0, 1, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),

                  borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text("The Key to Unlocking Your Financial Future",textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: 1.5,
                    color: clwhite
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height/2,
            ),
            InkWell(
              onTap: (){
                provider.getCustomerData();
                callNext(context, CreditersList());
              },
              child: Container(
                width: width/1.7,
                height: height/15,
                decoration: BoxDecoration(
                  color: cl3005e75,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Crediters",style: GoogleFonts.poppins(
                    color: clwhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                  ),),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
