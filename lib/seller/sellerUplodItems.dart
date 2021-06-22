import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/seller/myOrders.dart';
import 'package:e_shop/seller/sellerAddItemView.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _accountType = <String>[
    'Vegetables',
    'Fruits',
    'Seasonal Fruits',
    'Seasonal Vegetables',
    'Seeds'
  ];

  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEdditingController =
      TextEditingController();
  TextEditingController _priceTextEdditingController = TextEditingController();
  String selectedType; //for categeory
  TextEditingController _shortInfoTextEdditingController =
      TextEditingController();
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  TextEditingController _quentityTextEdditingController =
      TextEditingController();
  TextEditingController _nearestTownTextEdditingController =
      TextEditingController();
  TextEditingController _addressTownTextEdditingController =
      TextEditingController();
  TextEditingController _contactNoTextEdditingController =
      TextEditingController();
  TextEditingController _uNameoTextEdditingController = TextEditingController();

  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null
        ? displayAdminHomeScreen()
        : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              color: Colors.green,
              size: 200.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                      color: Colors.white,
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "Add New Items",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                        ),
                        color: Colors.green[800],
                        onPressed: () => takeImage(context),
                      )),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Container(
                      color: Colors.white,
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "View My Items",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                        ),
                        color: Colors.green[800],
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (c) => SellerItem());
                          Navigator.pushReplacement(context, route);
                        },
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  width: 330,
                  height: 100,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "View My Orders",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.green[800],
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => MyOrders());
                      Navigator.pushReplacement(context, route);
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Item Image",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture with camera",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.green[900], Colors.lightGreenAccent[700]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "New Product",
            style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50)),
              child: FlatButton(
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: uploading ? null : () => _saveForm(),
              ),
            )
          ],
        ),
        body: Form(
          key: _formKeyValue, //assigning key to form
          autovalidate: true,
          child: new ListView(
            children: <Widget>[
              uploading ? circularProgress() : Text(""),
              Container(
                height: 230.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(file), fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 12.0)),

              SizedBox(height: 20.0), //name
              new TextFormField(
                controller: _shortInfoTextEdditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                },
                decoration: const InputDecoration(
                  icon: const Icon(
                    Icons.perm_device_information,
                    color: Colors.green,
                  ),
                  hintText: 'Enter name of food item',
                  labelText: 'Name',
                ),
              ),

              SizedBox(height: 20.0), //categeory
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.category,
                    size: 25.0,
                    color: Colors.green[900],
                  ),
                  SizedBox(width: 100),
                  DropdownButton(
                    items: _accountType
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (selectedCategoryType) {
                      print('$selectedCategoryType');
                      setState(() {
                        selectedType = selectedCategoryType;
                      });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text(
                      'Select a Category',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20.0), //description
              new TextFormField(
                controller: _descriptionTextEdditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                },
                decoration: const InputDecoration(
                  icon: const Icon(
                    Icons.perm_device_information,
                    color: Colors.green,
                  ),
                  hintText: 'Enter short Description',
                  labelText: 'Description',
                ),
              ),

              SizedBox(height: 20.0), //quentity
              new TextFormField(
                  controller: _quentityTextEdditingController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '*Required';
                    }
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.perm_device_information,
                      color: Colors.green,
                    ),
                    hintText: 'The Quentity you can supply',
                    labelText: 'Quentity',
                  ),
                  keyboardType: TextInputType.number),

              SizedBox(height: 20.0), //price
              new TextFormField(
                  controller: _priceTextEdditingController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '*Required';
                    }
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.perm_device_information,
                      color: Colors.green,
                    ),
                    hintText: 'Enter Price of 1Kg',
                    labelText: 'Price (1 Kg)',
                  ),
                  keyboardType: TextInputType.number),

              SizedBox(height: 20.0), //town
              new TextFormField(
                controller: _nearestTownTextEdditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                },
                decoration: const InputDecoration(
                  icon: const Icon(
                    Icons.perm_device_information,
                    color: Colors.green,
                  ),
                  hintText: 'Enter your Nearest Town',
                  labelText: 'Nearest Town',
                ),
              ),

              SizedBox(height: 20.0), //address
              new TextFormField(
                controller: _addressTownTextEdditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required';
                  }
                },
                decoration: const InputDecoration(
                  icon: const Icon(
                    Icons.perm_device_information,
                    color: Colors.green,
                  ),
                  hintText: 'Enter Address of Marcketplace',
                  labelText: 'Address',
                ),
              ),

              SizedBox(height: 20.0), //contact
              new TextFormField(
                controller: _contactNoTextEdditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required';
                  }
                },
                decoration: const InputDecoration(
                  icon: const Icon(
                    Icons.perm_device_information,
                    color: Colors.green,
                  ),
                  hintText: 'Enter your Phone Details',
                  labelText: 'Phone',
                ),
              ),
              SizedBox(height: 20.0), //contact
              new TextFormField(
                controller: _uNameoTextEdditingController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required';
                  }
                },
                decoration: const InputDecoration(
                  icon: const Icon(
                    Icons.perm_device_information,
                    color: Colors.green,
                  ),
                  hintText: 'Enter your user Name',
                  labelText: 'User Name',
                ),
              ),
            ],
          ),
        ));
  }

  _saveForm() {
    // >ADD button
    final isValid = _formKeyValue.currentState.validate();
    if (isValid) {
      uploadImageAndSaveItemInfo();
    } else
      return null;
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _descriptionTextEdditingController.clear();
      _priceTextEdditingController.clear();
      //_titleTextEdditingController.clear();
      selectedType = null;
      _shortInfoTextEdditingController.clear();
      _nearestTownTextEdditingController.clear();
      _quentityTextEdditingController.clear();
      _addressTownTextEdditingController.clear();
      _contactNoTextEdditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    //> _saveIteminfo
    setState(() {
      uploading = true;
    });
    String imageDownloadUrl = await uploadItemImage(file);
    String uid = await inputData();
    saveItemInfo(imageDownloadUrl, uid);
  }

  Future<String> uploadItemImage(mFileImage) async {
    // >uploadImage And send imgUrl to SaveItemInfo()
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask =
        storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //to pass current_user_data to Selleruploaditem
  Future<String> inputData() async {
    final FirebaseUser _aUser = await FirebaseAuth.instance.currentUser();
    final String uid = _aUser.uid.toString();
    return uid;
  }

  saveItemInfo(String downloadUrl, String uid) {
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo": _shortInfoTextEdditingController.text.trim(),
      "longDescription": _descriptionTextEdditingController.text.trim(),
      "price": int.parse(_priceTextEdditingController.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      //"title": _titleTextEdditingController.text.trim(),
      "title": selectedType,
      "uid": uid,
      "productId": productId,
      "nearestTown": _nearestTownTextEdditingController.text.trim(),
      "quentity": int.parse(_quentityTextEdditingController.text.trim()),
      "address": _addressTownTextEdditingController.text.trim(),
      "contactNo": _contactNoTextEdditingController.text.trim(),
      "ename": _uNameoTextEdditingController.text.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().microsecondsSinceEpoch.toString();
      _descriptionTextEdditingController.clear();
      // _titleTextEdditingController.clear();
      selectedType = null;
      _shortInfoTextEdditingController.clear();
      _priceTextEdditingController.clear();
      _quentityTextEdditingController.clear();
      _nearestTownTextEdditingController.clear();
      _addressTownTextEdditingController.clear();
      _contactNoTextEdditingController.clear();
    });
  }
}
