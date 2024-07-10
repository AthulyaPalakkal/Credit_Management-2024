import 'package:credit_management/constants/my_colors.dart';
import 'package:credit_management/crediters_list.dart';
import 'package:credit_management/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class addcategory extends StatelessWidget {
  addcategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(3),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => addcategory()));
            },
            child: const Icon(Icons.arrow_back, color: clwhite)),
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text('Add category',
              style: TextStyle(
                  fontFamily: 'cantata', fontSize: 20, color: clwhite)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 50),
              child: Consumer<MainProvider>(builder: (context, value, child) {
                return TextField(
                  controller: value.nameController,
                  decoration: InputDecoration(
                      hintText: "Type here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Consumer<MainProvider>(builder: (context, value, child) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>CreditersList()));
              },
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black, spreadRadius: 10)
                    ],
                    color: Colors.yellow),
                child: const Center(
                    child: Text('Submit',
                        style: TextStyle(
                            fontFamily: 'cantata',
                            fontSize: 22,
                            color: clwhite,
                            fontWeight: FontWeight.bold))),
              ),
            );
          })
        ],
      ),
    );
  }
}
