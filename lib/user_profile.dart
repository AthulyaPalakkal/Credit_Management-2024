import 'package:credit_management/add_user.dart';
import 'package:credit_management/crediters_list.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';

class UserProfile extends StatelessWidget {
  String userid;
  String customername;
  String customerNumber;
  String customerPlace;
  String ccAmount;
  final int index;
  UserProfile({super.key, required this.index,
    required this.userid,
    required this.customername,
    required this.customerNumber,
    required this.customerPlace,
    required this.ccAmount
    });

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
        title: Text("User Profile",style: GoogleFonts.poppins(
            fontSize: 20,fontWeight: FontWeight.w500,
            color: clwhite,
            letterSpacing: 1.5
        ),),
        centerTitle: true,
        actions: [Consumer<MainProvider>(
          builder: (context, value, child) {
            return InkWell(onTap: (){
             value.clearcustomerdata();
             value.editcustomerData(userid);
             callNext(context, AddUser(frmId: "Edit",
                 toId: userid,));

            },
                child: Icon(Icons.edit,color: clwhite,size: 24,));
          }
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer<MainProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () => _showDeleteConfirmationDialog(context ,index),

                    child: Icon(Icons.delete_rounded,color: clwhite,size: 24,));
              }
            ),
          ),SizedBox(width: 8,)
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Consumer<MainProvider>(
            builder: (context,value,child) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: cl3005e75,
                      child: Icon(Icons.person_sharp,color: clwhite,size: 68,shadows: [Shadow(color: clblack.withOpacity(0.6),blurRadius: 20,)],),
                    ),
                  ),
                  Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return Center(
                        child: Text(value.customerlist[index].customername,style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: clblack,
                          letterSpacing: 1.2
                        ),),
                      );
                    }
                  ),
                  SizedBox(height:height/18,),
                  Row(
                    children: [
                      Icon(Icons.call_outlined,color: cl3005e75,size: 18,),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(value.customerlist[index].customerNumber,style: GoogleFonts.poppins(
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
                        child: Text(value.customerlist[index].customerPlace,style: GoogleFonts.poppins(
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text("Total Credit Amount : ",style: GoogleFonts.poppins(
                          fontSize: 18,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                            child: Row(
                              children: [

                                Text(value.customerlist[index].ccAmount,style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: clblack
                                ),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                  ),
                  SizedBox(height: 6,),
                  Divider(color: cl3005e75,indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(height:10,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     width: width,
                     height: height/16,
                     decoration: BoxDecoration(
                       color: cl3005e75,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: Center(
                       child: Text("Transaction History",style: GoogleFonts.poppins(
                         fontSize: 18,
                         fontWeight: FontWeight.w500,
                         color: clwhite,
                         letterSpacing: 1.5
                       ),),
                     ),
                   ),
                 ),
                 SizedBox(height: height/18,),


                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       InkWell(onTap: (){
                         _showAmountDialog(context);
                         },

                         child: Container(
                           width: width/2.9,
                           height: height/18,
                           decoration: BoxDecoration(
                            color: cl3005e75,
                             borderRadius: BorderRadius.circular(10),
                           ),
                           child: Center(
                             child: Text("Credit",style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w500,
                               fontSize: 18,
                               letterSpacing: 1.2,
                               color: clwhite
                             ),),
                           ),
                         ),
                       ),
                       Container(
                         width: width/2.9,
                         height: height/18,
                         decoration: BoxDecoration(
                          color: cl3005e75,
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Center(
                           child: Text("Debit",style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w500,
                               fontSize: 18,
                               color: clwhite,
                             letterSpacing: 1.2
                           ),),
                         ),
                       )

                     ],
                   ),
                 )


                ],
              );
            }
          ),
        ),
      ),

    );
  }
}
void _showAmountDialog(BuildContext context) {
  final amountController = TextEditingController();
  final creditProvider = Provider.of<MainProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount",
              ),
            ),
            SizedBox(height: 20),
            Consumer<MainProvider>(
              builder: (context, provider, child) {
                return Text(
                  provider.selectedDate == null
                      ? 'No Date Selected'
                      : 'Selected Date: ${provider.selectedDate!.toLocal()}'.split(' ')[0],
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  creditProvider.setDate(pickedDate);
                }
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {

              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Done"),
          ),
        ],
      );
    },
  );
}

void _showDeleteConfirmationDialog(BuildContext context, index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<MainProvider>(
        builder: (context, value, child) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure you want to delete this item?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(

                child: Text('Delete'),
                onPressed: () {
                  // Perform the delete operation here
                  value.deleteCustomer(context,
                      value.customerlist[index].id);
                  callNextReplacement(context, CreditersList());
                },
              ),
            ],
          );
        }
      );
    },
  );
}