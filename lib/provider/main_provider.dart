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

/// edit

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

  /// delete
  void deleteCustomer(context, idd) {
    db.collection("CUSTOMERS").doc(idd).delete();

    getCustomerData();
    notifyListeners();
  }


  // add owner

  TextEditingController ownernameController = TextEditingController();
  TextEditingController ownerphoneController = TextEditingController();
  TextEditingController shopnameController = TextEditingController();

  File? ownerprofileimage ;
  String profileimageurl = "";
  File? shoplogoimage ;
  String shoplogourl = "";



  Future<void> addOwner() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> addownermap = HashMap();
    addownermap["OWNER_ID"] = id.toString();
    addownermap['OWNER_NAME'] = ownernameController.text;
    addownermap['PHONE_NUMBER'] = ownerphoneController.text;
    addownermap['SHOP_NAME'] = shopnameController.text;
    if ( ownerprofileimage!= null) {
      String profileimgid = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(profileimgid);
      await ref.putFile(ownerprofileimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          addownermap["PHOTO"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }else if (profileimageurl != "") {
      addownermap["PHOTO"] = profileimageurl;
    } else {
      addownermap['PHOTO'] = "";
    }

    if ( shoplogoimage!= null) {
      String logoimgid = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(logoimgid);
      await ref.putFile(shoplogoimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          addownermap["LOGO"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
    }else if (shoplogourl != "") {
      addownermap["LOGO"] = shoplogourl;
    } else {
      addownermap['LOGO'] = "";
    }

    db.collection("OWNER_DETAILS").doc(id).set(addownermap);
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















  // date

  DateTime? _selectedDate;
  double _totalAmount = 0.0;

  DateTime? get selectedDate => _selectedDate;
  double get totalAmount => _totalAmount;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void addAmount(String amount) {
    _totalAmount += double.parse(amount);
    notifyListeners();
  }


}


