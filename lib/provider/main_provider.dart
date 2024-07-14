import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/constants/model_class.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MainProvider extends ChangeNotifier {

  firebase_storage.Reference ref = FirebaseStorage.instance.ref("IMAGEURL");

  final FirebaseFirestore db = FirebaseFirestore.instance;



// add ,edit, delete,customers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future<void> addCustomer(BuildContext context ,String frm, String uid) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> addcustomermap = HashMap();
    addcustomermap['CUSTOMER NAME'] = nameController.text;
    addcustomermap['NUMBER'] = phoneController.text;
    addcustomermap['PLACE'] = placeController.text;
    addcustomermap['CREDIT AMOUNT'] = amountController.text;
    if (frm == "NEW") {
      addcustomermap['CUSTOMER ID'] = id;
    }
    if (frm == "NEW") {
      db.collection("CUSTOMERS").doc(id).set(addcustomermap, SetOptions(merge: true));
    } else {
      db.collection("CUSTOMERS").doc(uid).set(addcustomermap, SetOptions(merge: true));
      const snackBar = SnackBar(
        content: Text("Updated"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    getCustomerData();
  }

  /// get customer
  List<customeradd> customerlist = [];
  void getCustomerData() {
    db.collection("CUSTOMERS").get().then((value) {
      print("asadgg");
      if (value.docs.isNotEmpty) customerlist.clear();
      {
        for (var element in value.docs) {
          customerlist.add(customeradd(element.id,
            element.get("CUSTOMER NAME").toString(),
            element.get("NUMBER").toString(),
            element.get("PLACE").toString(),
            element.get("CREDIT AMOUNT").toString(),


          ));
          notifyListeners();
          print(customerlist.length.toString());
        }
      }
    });
  }

  void clearcustomerdata() {
    nameController.clear();
    phoneController.clear();
    placeController.clear();
    amountController.clear();
  }



  /// edit customer

  void editcustomerData(String id){

    db.collection("CUSTOMERS").doc(id).get().then((value) {
      if(value.exists){
        Map<dynamic, dynamic> addcustomermap = value.data() as Map;
        nameController.text = addcustomermap["CUSTOMER NAME"].toString();
        phoneController.text = addcustomermap["NUMBER"].toString();
        placeController.text = addcustomermap["PLACE"].toString();
        amountController.text = addcustomermap["CREDIT AMOUNT"].toString();
        notifyListeners();
      }
    });
  }

  /// delete customer
  void deleteCustomer(context, idd) {
    db.collection("CUSTOMERS").doc(idd).delete();

    getCustomerData();
    notifyListeners();
  }
/// getowner
  List<owneradd> ownerlist = [];

  void getOwnerData() {
    db.collection("OWNER_DETAILS").get().then((value) {
      print("asadgg");
      if (value.docs.isNotEmpty) ownerlist.clear();
      {
        for (var element in value.docs) {
          ownerlist.add(owneradd(element.id,
            element.get("PHOTO").toString(),
            element.get("OWNER_NAME").toString(),
            element.get("PHONE_NUMBER").toString(),
            element.get("SHOP_NAME").toString(),
            element.get("LOGO").toString(),

          ));
          notifyListeners();
          print(ownerlist.length.toString());
        }
      }
    });
  }


  /// number check for checking already existing number

  Future<bool> numberChcek(String number) async {
    var val=await db
        .collection("OWNER_DETAILS")
        .where("PHONE_NUMBER", isEqualTo: "+91" + number)
        .get();
    if(val.docs.isNotEmpty){
      return true;
    }else{
      return false;
    }

  }

/// add owner

  void clearownerdata() {
    ownernameController.clear();
    ownerphoneController.clear();
    shopnameController.clear();
    ownerprofileimage= null;
    shoplogoimage =null;


  }


  TextEditingController ownernameController = TextEditingController();
  TextEditingController ownerphoneController = TextEditingController();
  TextEditingController shopnameController = TextEditingController();

  File? ownerprofileimage = null ;
  String profileimageurl = "";
  File? shoplogoimage =null;
  String shoplogourl = "";



  Future<void> addOwner(BuildContext context) async {
    bool isChecked = await numberChcek(
        phoneController.text);
    if (!isChecked){
      print("vfvfvfv");
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      HashMap<String, Object> addownermap = HashMap();
      addownermap["OWNER_ID"] = id.toString();
      addownermap['OWNER_NAME'] = ownernameController.text;
      addownermap['PHONE_NUMBER'] = "+91${ownerphoneController.text}";
      addownermap['SHOP_NAME'] = shopnameController.text;
      print("dcdccdcdcdc");



      if (ownerprofileimage != null) {
        String photoId = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        ref = FirebaseStorage.instance.ref().child(photoId);
        await ref.putFile(ownerprofileimage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            addownermap["PHOTO"] = value;

            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } else {
        addownermap['PHOTO'] = profileimageurl;
      }

      if ( shoplogoimage!= null) {
        print("jjjjjjjjjjjjjjjjjjjjjjjj");
        String logoimgid = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child(logoimgid);
        await ref.putFile(shoplogoimage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            addownermap["LOGO"] = value;
            notifyListeners();
          });
          notifyListeners();
        });
      } else {
        addownermap["LOGO"] = shoplogourl;
      }

      db.collection("OWNER_DETAILS").doc(id).set(addownermap);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Number already exists!"))
      );
    }

  }


  Future getImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      cropImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      cropImage(pickedImage.path);
      // setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        ownerprofileimage = File(croppedFile.path);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      print('Error cropping image: $e');
    }
  }



  Future getlogoImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      croplogoImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getlogoImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      croplogoImage(pickedImage.path);
      // setImage(File(pickedImage.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> croplogoImage(String path) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {

        shoplogoimage  = File(croppedFile.path);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      print('Error cropping image: $e');
    }
  }
/// date picking

  // TimeOfDay _time = TimeOfDay.now();
  // DateTime _date = DateTime.now();
  // DateTime scheduledTime = DateTime.now();
  // DateTime scheduledDate = DateTime.now();
  // String scheduledDayNode = "";
  // var outputDateFormat = DateFormat('dd/MM/yyyy');
  // var outputTimeFormat = DateFormat('hh:mm a');
  // TextEditingController dateController = TextEditingController();
  // TextEditingController timeController = TextEditingController();
  //


  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: DateTime(2018),
  //     lastDate: DateTime(2100),
  //   );
  //
  //   if (picked != null) {
  //     _date = picked;
  //     scheduledDate = DateTime(_date.year, _date.month, _date.day);
  //     dateController.text = outputDateFormat.format(scheduledDate);
  //   }
  // }
  //
  // Future<void> selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //
  //   if (picked != null) {
  //     _time = picked;
  //     scheduledDayNode =
  //         _date.year.toString() + '/' + _date.month.toString() + '/' +
  //             _date.day.toString();
  //     scheduledTime = DateTime(
  //         _date.year, _date.month, _date.day, _time.hour, _time.minute);
  //     timeController.text = outputTimeFormat.format(scheduledTime);
  //   }
  // }

  /// transaction history



  List<HistoryMode> transactionHistoryList=[];
  void fetchHistory(String custId) {
    print('called');
    transactionHistoryList.clear();
    db.collection("TRANSACTIONS").where("USER_ID", isEqualTo: custId).get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          Map<String, dynamic> map = element.data() as Map<String, dynamic>;
          transactionHistoryList.add(HistoryMode(
            element.id,
            map["TRANSACTION_DATE"] ?? "",
            map["AMOUNT"] ?? "",
            map["TRANSACTION_TYPE"] ?? "",
          ));
          notifyListeners();
        }
      }
    });
  }




/// credit and debit


  TextEditingController creditControler=TextEditingController();

  // void addCreadit(String custId,String creditAmount){
  //   int? total=0;
  //   total=int.parse(creditAmount)+int.parse(creditControler.text);
  //   db.collection("CUSTOMERS").doc(custId).set({"CREDIT AMOUNT":total.toString()},SetOptions(merge: true));
  //  notifyListeners();
  //  getCustomerData();
  //
  // }
  void clearcredit() {
    creditControler.clear();
    debitControler.clear();
  }

  void addCreadit(String custId,String creditAmount){

    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yyyy').format(addDate);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> paymentMap = HashMap();
    paymentMap['TRANSACTION_ID'] = id;
    paymentMap['TRANSACTION_DATE'] = date;
    paymentMap['TRANSACTION_TYPE'] = "CREDIT";
    // paymentMap['STUDENT_NAME'] = studentName;
    paymentMap['AMOUNT'] = creditControler.text;
    paymentMap['USER_ID'] = custId;
    db.collection("TRANSACTIONS").doc(id).set(paymentMap, SetOptions(merge: true));
    int? total=0;
    total=int.parse(creditAmount)+int.parse(creditControler.text);
    db.collection("CUSTOMERS").doc(custId).set({"CREDIT AMOUNT":total.toString()},SetOptions(merge: true));
   fetchHistory(custId);
   getCustomerData();
   notifyListeners();

  }


  /// debit
  void adddebit(String custId,String debitAmount){

    DateTime addDate = DateTime.now();
    String date = DateFormat('dd/MM/yyyy').format(addDate);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> paymentdebitMap = HashMap();
    paymentdebitMap['TRANSACTION_ID'] = id;
    paymentdebitMap['TRANSACTION_DATE'] = date;
    paymentdebitMap['TRANSACTION_TYPE'] = "DEBIT";
    // paymentMap['STUDENT_NAME'] = studentName;
    paymentdebitMap['AMOUNT'] = debitControler.text;
    paymentdebitMap['USER_ID'] = custId;
    db.collection("TRANSACTIONS").doc(id).set(paymentdebitMap, SetOptions(merge: true));
    int? total=0;
    total=int.parse(debitAmount)-int.parse(debitControler.text);
    db.collection("CUSTOMERS").doc(custId).set({"CREDIT AMOUNT":total.toString()},SetOptions(merge: true));
    fetchHistory(custId);
    getCustomerData();
    notifyListeners();

  }

  TextEditingController debitControler=TextEditingController();

  // void adddebit(String custId,String debitAmount){
  //   int? total=0;
  //   total=int.parse(debitAmount)-int.parse(debitControler.text);
  //   db.collection("CUSTOMERS").doc(custId).set({"CREDIT AMOUNT":total.toString()},SetOptions(merge: true));
  //   notifyListeners();
  //   getCustomerData();
  //
  // }
  void cleardebit() {
    creditControler.clear();

  }




  double _totalAmount = 0.0;
  double _totalAmounts = 0.0;

  double get totalAmount => _totalAmount;
  double get totalAmounts => _totalAmounts;



  void addAmount(String amount) {
  _totalAmount += double.parse(amount);
  notifyListeners();
  }

  void subtractAmount(String amount) {
    _totalAmounts -= double.parse(amount);
    notifyListeners();
  }









}


