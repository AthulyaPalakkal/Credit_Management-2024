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

  String name;
  String phone;
  String userId;
  String photo;
  String shoplogo;
  String shopname;

  HomeScreen({super.key,required this.name,required this.phone,required this.userId,
    required this.photo,required this.shoplogo, required this.shopname });
  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context,listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("dghfgds"+shopname);
    print("dghfgds"+shoplogo);

    return Scaffold(
      backgroundColor: clwhite,
      appBar: AppBar(
        backgroundColor: cl3005e75,
        toolbarHeight: 100,

      leading: Image.network(shoplogo,scale: 1,),leadingWidth: 80,

        actions: [ Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(photo),
          ),
        ),],
        title: Row(
          children: [

          Padding(
            padding: const EdgeInsets.only(left:30),
            child: Text(shopname,style: GoogleFonts.poppins(
                fontSize: 22,fontWeight:FontWeight.w500,
                color: clwhite,letterSpacing: 1.5
              ),),
          ),
          ],
        ),
        centerTitle: true,
      ),

      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width/1.2,
              height: height/6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage('assets/credithome.jpg'),fit: BoxFit.fill)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width/1.2,
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
                child: SizedBox(width: width/1.6,
                  child: Text("The Key to Unlocking Your Financial Future ",textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: 1.9,
                      color: clwhite
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height/6.7,),
            InkWell(onTap: (){
              provider.getOwnerData();
              callNext(context, ShopownerProfile(name: name, phone: phone, userId: userId, photo: photo, shoplogo: shoplogo, shopname:shopname,));
            },
              child: Container(
                width: width/1.2,
                height: height/15,
                decoration: BoxDecoration(
                    color: cl3005e75,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Your Profile",style: GoogleFonts.poppins(
                      color: clwhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                  ),),
                ),
              ),
            ),
            SizedBox(
              height: height/22
            ),
            InkWell(
              onTap: (){
                provider.getCustomerData();
                callNext(context, CreditersList());
              },
              child: Center(
                child: Container(
                  width: width/1.2,
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
              ),
            )

          ],
        ),
      ),
    );
  }
}
