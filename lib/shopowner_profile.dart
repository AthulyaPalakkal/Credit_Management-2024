import 'package:credit_management/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';

class ShopownerProfile extends StatelessWidget {
  String name;
  String phone;
  String userId;
  String photo;
  String shoplogo;
  String shopname;
   ShopownerProfile({super.key,required this.name,required this.phone,required this.userId,
    required this.photo,required this.shoplogo, required this.shopname });

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
        title:
        Text(shopname,style: GoogleFonts.poppins(
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
                  radius: 50,
                  backgroundColor: cl3005e75,
                  backgroundImage: NetworkImage(photo),
                ),
              ),
              Center(
                child: Text(name,style: GoogleFonts.poppins(
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
                    child: Text(phone,style: GoogleFonts.poppins(
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
              GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor:cl3005e75.withOpacity(0.8),
                        content: const Text(
                          "Are you sure want to Sign-out?",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Amikosemi",
                            color: clwhite,
                          ),
                        ),
                        actions: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  auth.signOut();
                                  callNextReplacement(context, const LoginPage());
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(fontSize: 15, color: Colors.red,fontFamily: "AmikoRegular",),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  finish(context);
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(fontSize: 15, color:clwhite,fontFamily: "AmikoRegular",),
                                ),
                              ),
                            ],)

                        ],
                      ),
                    );

                  },
                  child: Container(
                    height: height / 13,
                    width: width / 1.5,
                    decoration: BoxDecoration(
                        color:cl3005e75,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sign Out",
                              style: TextStyle(
                                color: clwhite,
                                fontSize: 16,
                                fontFamily: 'Amikosemi',
                              )),
                          Icon(
                              Icons.logout_rounded,
                            color: Color(0xfff8f7f4),
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  ),







              ),
            ],
          ),
        ),
      ),

    );
  }
}
