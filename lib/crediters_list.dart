
import 'package:credit_management/provider/main_provider.dart';
import 'package:credit_management/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_user.dart';
import 'constants/functions.dart';
import 'constants/my_colors.dart';


String getAmount(double totalCollection) {

  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}

class CreditersList extends StatelessWidget {
  const CreditersList({super.key});

  @override
  Widget build(BuildContext context) {
    var value = context.watch<MainProvider>();
    double totalCreditAmount = value.customerlist.fold(0, (sum, customer) {
      return sum + double.parse(customer.ccAmount);
    });

    MainProvider provider = Provider.of<MainProvider>(context,listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: clwhite,
      appBar: AppBar(
        backgroundColor: cl3005e75,
        toolbarHeight: 90,
        leading: InkWell(
          onTap: (){
            back(context);
          },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: clwhite,)),
        title: Text("Total Credits",style: GoogleFonts.poppins(
          fontSize: 20,fontWeight: FontWeight.w500,
          color: clwhite,
          letterSpacing: 1.5
        ),),
        actions: [
          Container(
            height: height/18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(
                 color: clwhite.withOpacity(0.6),
              )
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${totalCreditAmount.toStringAsFixed(2)}",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: clwhite
                  ),),
                ),
              ],
            ),
          ),SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(width: width/3,
          height: height/17,
          child: FloatingActionButton(
            backgroundColor: cl3005e75,
            onPressed: () {
              provider.clearcustomerdata();
              callNext(context, AddUser(frmId: "NEW", toId: ""));
            },
            child:Text("Add user",style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: clwhite
            ),)
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Consumer<MainProvider>(
                builder: (context,value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.customerlist.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var items = value.customerlist[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: cl3005e75,
                            ),boxShadow: [BoxShadow(color: cl3005e75.withOpacity(0.2),
                          blurStyle: BlurStyle.outer,blurRadius: 4,spreadRadius: 0)],
                            borderRadius: BorderRadius.circular(15),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                  Row(
                                    children: [
                                      Text("Name : ",style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: clblack
                                      ),),
                                      Text(value.customerlist[index].customername,style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: clblack
                                      ),)

                                    ],
                                  ),
                                SizedBox(height:8,),
                                Row(
                                  children: [
                                    Text("Phone no. : ",style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: clblack
                                    ),),
                                    Text(value.customerlist[index].customerNumber,style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: clblack
                                    ),)

                                  ],
                                ),
                                SizedBox(height:8,),
                                Row(
                                  children: [
                                    Text("Credit Amount : ",style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: clblack
                                    ),),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: cl3005e75),
                                        borderRadius: BorderRadius.circular(8),

                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [

                                            Builder(
                                              builder: (context) {
                                                return Text(value.customerlist[index].ccAmount,style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: clblack
                                                ),);
                                              }
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: ()
                                        {
                                          provider.getCustomerData();
                                          callNext(context, UserProfile(index: index,
                                             userid: items.id,
                                            customername: items.customername,
                                            customerNumber:items.customerNumber,
                                            customerPlace: items.customerPlace,
                                            ccAmount: items.ccAmount,



                                           ));
                                        },
                                        child: Icon(Icons.arrow_circle_right_rounded,color: cl3005e75,size: 30,))


                                  ],
                                ),

                              ],
                            ),
                          ),

                        ),
                      );
                    },
                  );
                }
              ),
              SizedBox(height: height/10,)
            ],
          ),
        ),
      ),
    );
  }
}
