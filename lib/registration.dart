import 'package:credit_management/constants/functions.dart';
import 'package:credit_management/login_page.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/my_colors.dart';

class Registration extends StatelessWidget {
  final _Fmkey = GlobalKey<FormState>();
   Registration({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return   Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _Fmkey,
          child: SingleChildScrollView(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  colors: [Color(0xff005e75), Color(0xffc2c2b7), Color(0xff8fa7bd)],
                  stops: [0, 1, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,
                  vertical: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height/9,),
                      Center(
                        child: Container(
                          width: width/1.9,
                          height: height/6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors.transparent,
                            border: Border.all(color: clwhite)
                          ),
                          child: Consumer<MainProvider>(builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () {
                                showBottomSheet(context);
                              },
                              child: value.ownerprofileimage != null
                                  ? CircleAvatar(
                                backgroundImage: FileImage(value.ownerprofileimage!),
                                radius: 50,
                              )
                                  : value.profileimageurl != ""
                                  ? CircleAvatar(
                                backgroundImage: NetworkImage(value.profileimageurl),
                                radius: 50,
                              )
                                  : CircleAvatar(
                                    child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color:  clblack.withOpacity(0.6),size: 52,
                                ),
                                backgroundColor: Colors.transparent,
                                radius: 50,
                              ),
                            );
                          }),

                          // Icon(Icons.add_a_photo_outlined,color: clblack.withOpacity(0.6),size: 52,),
                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(width: width/1.2,
                        child: Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return TextFormField(
                              validator: (value) {
                                if(value==null||value.isEmpty){
                                  return "*required";
                                }
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: clwhite,
                              ),
                              keyboardType: TextInputType.name,
                              controller: value.ownernameController,
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
                      SizedBox(height: 20,),
                      SizedBox(width: width/1.2,
                        child: Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return TextFormField(
                              validator: (value) {
                                if(value==null||value.isEmpty){
                                  return "*required";
                                }
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: clwhite,
                              ),
                              keyboardType: TextInputType.number,
                              controller: value.ownerphoneController,
                              inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              decoration: const InputDecoration(
                                focusColor: Colors.black38,
                                label: Text(
                                  "Mobile Number",
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
                      ),SizedBox(height: 20,),
                      SizedBox(width: width/1.2,
                        child: Consumer<MainProvider>(
                          builder: (context, value,child) {
                            return TextFormField(
                              validator: (value) {
                                if(value==null||value.isEmpty){
                                  return "*required";
                                }
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: clwhite,
                              ),
                              keyboardType: TextInputType.name,
                              controller: value.shopnameController,
                              decoration: const InputDecoration(
                                focusColor: Colors.black38,
                                label: Text(
                                  "Shop Name",
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
                      ),SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            Text("Shop Logo :",style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: clwhite
                            ),),
                            Consumer<MainProvider>(
                              builder: (context, value, child) {
                                return GestureDetector(onTap: (){
                                  showlogoBottomSheet(context);
                                },
                                  child: value.shoplogoimage != null
                                  ?Container(
                                    width: width/2,
                                    height: height/8,
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(10),
                                      border: Border.all(color: clwhite),
                                    ),
                                    child: Image.file(
                                      value.shoplogoimage!,
                                      fit: BoxFit.fill,
                                    )):Container(
                                    width: width/2,
                                    height: height/8,
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(10),
                                      border: Border.all(color: clwhite),
                                    ),
                                    child: Icon(Icons.add_photo_alternate_outlined,
                                      color: clblack.withOpacity(0.6),size: 40,),
                                  ),

                                  );


                              }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height/16,),
                      Consumer<MainProvider>(
                        builder: (context, value,child) {
                          return InkWell(
                            onTap: () async {
                              final FormState? form = _Fmkey.currentState;if (form!.validate()) {
                                bool isChecked = await value.numberChcek(
                                    value.phoneController.text);
                                if (!isChecked){
                                  value.addOwner(context);
                                  callNext(context, LoginPage());
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Number already exists!"))
                                  );
                                }

                              }

                            },
                            child: Container(
                              width: width/1.2,
                              height: height/16,
                              decoration: BoxDecoration(
                                color: cl3005e75,
                                boxShadow: [BoxShadow(
                                  color: cl3005e75.withOpacity(0.4),blurStyle: BlurStyle.outer,blurRadius: 2,spreadRadius: 0
                                )],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("Register",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: clwhite
                                ),),
                              ),
                            ),
                          );
                        }
                      ),
                      TextButton(
                          onPressed: () {
                            callNext(context, LoginPage());
                          },
                          child: Text(
                           "Already have an account? Login!" ,
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Amikosemi', color: clwhite),
                          )),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  }
}
void showBottomSheet(BuildContext context) {
  MainProvider provider = Provider.of<MainProvider>(context, listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.camera_enhance_sharp,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Camera',
                ),
                onTap: () =>
                {provider.getImagecamera(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.photo, color: Colors.deepPurple),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.getImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
}

void showlogoBottomSheet(BuildContext context) {
  MainProvider provider = Provider.of<MainProvider>(context, listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[

            ListTile(
                leading: Icon(Icons.photo, color: Colors.deepPurple),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.getlogoImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
}


