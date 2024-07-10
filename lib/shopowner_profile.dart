import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';

class ShopownerProfile extends StatelessWidget {
  const ShopownerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cl3005e75,
        toolbarHeight: 80,
        leading: InkWell(
            onTap: (){
              back(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: clwhite,)),
        title: Text("Profile",style: GoogleFonts.poppins(
            fontSize: 20,fontWeight: FontWeight.w500,
            color: clwhite,
            letterSpacing: 1.5
        ),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: cl3005e75,
                  child: Icon(Icons.person_sharp,color: clwhite,size: 68,shadows: [Shadow(color: clblack.withOpacity(0.6),blurRadius: 20,)],),
                ),
              ),
              Center(
                child: Text("Athulya",style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: clblack,
                    letterSpacing: 1.2
                ),),
              ),
              SizedBox(height:height/18,),
              Row(
                children: [
                  Icon(Icons.call_outlined,color: cl3005e75,size: 18,),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text("8301018665",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: clblack
                    ),),
                  ),


                ],
              ),
              SizedBox(height: 6,),
              Divider(color: cl3005e75,indent: 10,
                endIndent: 10,
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,color: cl3005e75,size: 18,),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text("palakkad",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: clblack
                    ),),
                  ),


                ],
              ),
              SizedBox(height: 6,),
              Divider(color: cl3005e75,indent: 10,
                endIndent: 10,
              ),
              SizedBox(height: 15,),







            ],
          ),
        ),
      ),

    );
  }
}
