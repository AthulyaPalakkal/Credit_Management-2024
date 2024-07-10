import 'package:credit_management/crediters_list.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';

class AddUser extends StatelessWidget {
  String frmId;
  String toId;
 AddUser({super.key, required this.frmId, required this.toId,});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: clwhite,
      appBar: AppBar(
        backgroundColor: cl3005e75,
        toolbarHeight: 80,
        leading: InkWell(
            onTap: (){
              back(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: clwhite,)),
        title: Text("Add User",style: GoogleFonts.poppins(
            fontSize: 20,fontWeight: FontWeight.w500,
            color: clwhite,
            letterSpacing: 1.5
        ),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              SizedBox(height:height/16,),
              Container(
                width: width,
                height: height/1.4,
                decoration: BoxDecoration(
                 gradient: LinearGradient(
                   colors: [cl3005e75, clc2c2b7,cl8fa7bd],
                   stops: [0, 1, 1],
                   begin: Alignment.bottomCenter,
                   end: Alignment.topCenter,
                 ),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [BoxShadow(color: cl3005e75,
                  spreadRadius: 0,
                  blurRadius: 2, blurStyle: BlurStyle.outer)]


                ),
                child: Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              SizedBox(width: width/1.4,
                                child: Consumer<MainProvider>(
                                  builder: (context,value,child) {
                                    return TextFormField(
                                      controller: value.nameController,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: clwhite,
                                      ),
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        focusColor: Colors.black38,
                                        label: Text(
                                          "Name",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: clwhite,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: clwhite,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: clwhite,),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(width: width/1.4,
                                child: TextFormField(
                                  controller: value.phoneController,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: clwhite,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                  decoration: const InputDecoration(
                                    focusColor: Colors.black38,
                                    label: Text(
                                      "Number",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: clwhite,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: clwhite,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: clwhite,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(width: width/1.4,
                                child: TextFormField(
                                  controller: value.placeController,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: clwhite,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    focusColor: Colors.black38,
                                    label: Text(
                                      "Place",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: clwhite,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: clwhite,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: clwhite,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              SizedBox(width: width/1.4,
                                child: TextFormField(
                                  controller: value.amountController,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: clwhite,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    focusColor: Colors.black38,
                                    label: Text(
                                      "Credit Amount",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: clwhite,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: clwhite,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: clwhite,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return InkWell(
                              onTap: (){
                                if(toId==""){
                                  value.addCustomer(context, "NEW", "",);

                                }else{
                                  value.addCustomer(context, "Edit", toId);
                                }
                               back(context);

                              },
                              child: Container(width: width/3,
                                height: height/18,
                                decoration: BoxDecoration(
                                  color: clwhite,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: frmId == "NEW"

                                ? Center(
                                  child: Text("Add",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: cl3005e75
                                  ),),
                                )
                                    :Center(
                                  child: Text("Update",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: cl3005e75
                                  ),),
                                )
                              ),
                            );
                          }
                        )
                      ],
                    );
                  }
                ),


              )
            ],
          ),
        ),
      ),
    );
  }
}
