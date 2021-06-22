import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/mainHomePage/mainHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_shop/mainHomePage/MainPages/sellerUploadItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';

class SellerItem extends StatefulWidget {
  @override
  _SellerItemState createState() => _SellerItemState();
}

class _SellerItemState extends State<SellerItem> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _updateShortInfoTextEdditingController =
      TextEditingController();
  TextEditingController _updateDescriptionTextEdditingController =
      TextEditingController();
  TextEditingController _updatePriceTextEdditingController =
      TextEditingController();
  TextEditingController _updateQuentityTextEdditingController =
      TextEditingController();
  TextEditingController _updateNearestTownTextEdditingController =
      TextEditingController();
  TextEditingController _updateAddressTownTextEdditingController =
      TextEditingController();
  TextEditingController _updateContactNoTextEdditingController =
      TextEditingController();

  double width;
  int price;

  Stream<QuerySnapshot> getData() async* {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    yield* Firestore.instance
        .collection('items')
        .where("uid", isEqualTo: user.uid)
        .limit(15)
        .orderBy(
          "publishedDate",
          descending: true,
        )
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.green[900], Colors.lightGreenAccent[700]],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: Text(
          "Govigedara",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //back button
              Route route = MaterialPageRoute(builder: (c) => MainHomePage());
              Navigator.pushReplacement(context, route);
            }),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
          StreamBuilder<QuerySnapshot>(
            stream: getData(),
            builder: (context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
              return !dataSnapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        ItemModel model =
                            ItemModel.fromJson(//create model object
                                dataSnapshot.data.documents[index].data);
                        return sourceInfo(model, context);
                      },
                      itemCount: dataSnapshot.data.documents.length,
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    return InkWell(
      splashColor: Colors.pink,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 210.0,
          width: width,
          child: Row(
            children: [
              Image.network(
                model.thumbnailUrl, //item image
                width: 140.0,
                height: 180.0,
              ),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.shortInfo,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(model.title),
                  SizedBox(height: 5),
                  Text(model.price.toString()),
                  SizedBox(height: 5),
                  Text(model.address),
                  SizedBox(height: 5),
                  Text(model.quentity.toString()),
                  SizedBox(height: 5),
                  Text(model.contactNo),
                  SizedBox(height: 5),
                  Text(model.nearestTown),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(model.longDescription),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.pink,
                  )
                ],
              )),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Item'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Text('Would you like to delete this Item?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Confirm'),
                                  onPressed: () async {
                                    Firestore.instance
                                        .collection("items")
                                        .document(model.productId)
                                        .delete()
                                        .then((value) {
                                      print("Success!");
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            //Item update popup Dialog box
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Edit Item Information"),
                                content: Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          setState(() {
                                            _updateShortInfoTextEdditingController
                                                .clear();
                                            _updatePriceTextEdditingController
                                                .clear();
                                            _updateDescriptionTextEdditingController
                                                .clear();
                                            _updateQuentityTextEdditingController
                                                .clear();
                                            _updateNearestTownTextEdditingController
                                                .clear();
                                            _updateAddressTownTextEdditingController
                                                .clear();
                                            _updateContactNoTextEdditingController
                                                .clear();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'Update Item Name',
                                              labelText: 'Name',
                                            ),
                                            controller:
                                                _updateShortInfoTextEdditingController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'Set Price of 1kg',
                                              labelText: 'Price',
                                            ),
                                            controller:
                                                _updatePriceTextEdditingController,
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Update Item Description',
                                              labelText: 'Description',
                                            ),
                                            controller:
                                                _updateDescriptionTextEdditingController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Update Availble Quentity',
                                              labelText: 'Quentity',
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller:
                                                _updateQuentityTextEdditingController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'Update Nearest Town',
                                              labelText: 'Nearest Town',
                                            ),
                                            controller:
                                                _updateNearestTownTextEdditingController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'Update Item Address',
                                              labelText: 'Address',
                                            ),
                                            controller:
                                                _updateAddressTownTextEdditingController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Update Your Contact no',
                                              labelText: 'Contact No',
                                            ),
                                            keyboardType: TextInputType.number,
                                            controller:
                                                _updateContactNoTextEdditingController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return '*Required';
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                              child: Text("Update"),
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  Firestore.instance
                                                      .collection("items")
                                                      .document(model.productId)
                                                      .updateData({
                                                    "shortInfo":
                                                        _updateShortInfoTextEdditingController
                                                            .text
                                                            .trim(),
                                                    "price": int.parse(
                                                        _updatePriceTextEdditingController
                                                            .text),
                                                    "longDescription":
                                                        _updateDescriptionTextEdditingController
                                                            .text
                                                            .trim(),
                                                    "quentity":
                                                        _updateQuentityTextEdditingController
                                                            .text
                                                            .trim(),
                                                    "nearestTown":
                                                        _updateNearestTownTextEdditingController
                                                            .text
                                                            .trim(),
                                                    "address":
                                                        _updateAddressTownTextEdditingController
                                                            .text
                                                            .trim(),
                                                    "contactNo":
                                                        _updateContactNoTextEdditingController
                                                            .text
                                                            .trim(),
                                                  });

                                                  setState(() {
                                                    _updateDescriptionTextEdditingController
                                                        .clear();
                                                    _updateShortInfoTextEdditingController
                                                        .clear();
                                                    _updatePriceTextEdditingController
                                                        .clear();
                                                    _updateQuentityTextEdditingController
                                                        .clear();
                                                    _updateNearestTownTextEdditingController
                                                        .clear();
                                                    _updateAddressTownTextEdditingController
                                                        .clear();
                                                    _updateContactNoTextEdditingController
                                                        .clear();
                                                  });

                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.edit)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
