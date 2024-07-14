import 'package:credit_management/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/functions.dart';
import 'constants/my_colors.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    MainProvider provider = Provider.of<MainProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cl3005e75,
        toolbarHeight: 90,
        leading: InkWell(
            onTap: () {
              back(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: clwhite,
            )),
        title: Text(
          "Transaction History",
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: clwhite,
              letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Consumer<MainProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.transactionHistoryList.length,
                    itemBuilder: (context, index) {
                      return Consumer<MainProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              Container(
                                width: width,


                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            value.transactionHistoryList[index].type == "CREDIT" ? Icons.add : Icons.remove,
                                            color: value.transactionHistoryList[index].type == "CREDIT" ? Colors.red : Colors.green,
                                          ),                                             Icon(Icons.currency_rupee_outlined,color: clblack,size: 16,),
                                          Text(value.transactionHistoryList[index].amount,style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:value.transactionHistoryList[index].type == "CREDIT" ? Colors.red : Colors.green,
                                          ),),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(value.transactionHistoryList[index].date,style: GoogleFonts.poppins(
                                          fontSize: 12,fontWeight: FontWeight.w500,
                                          color:value.transactionHistoryList[index].type == "DEBIT" ? Colors.green : Colors.red,
                                        ),),
                                      )
                                    ],
                                  ),
                                ),
                              ),Divider(
                                color: clblack.withOpacity(0.6)
                              )
                            ],
                          );
                        }
                      );
                    },
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
