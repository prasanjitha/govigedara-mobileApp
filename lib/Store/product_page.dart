import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/ChatWithBuyer/views/directSignIN.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';

import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'afterAddingCart.dart';
import 'cart.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  ProductPage({this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double quantityOfItems = 1;
  double totalQuentityOfItems = 0;
  double totalPrice = 0;
  double aq = 100.0;

  void _increment() {
    setState(() {
      totalQuentityOfItems = totalQuentityOfItems + 0.5;
      totalPrice = totalQuentityOfItems * widget.itemModel.price.toInt();
      aq = widget.itemModel.quentity.toDouble() -
          totalQuentityOfItems.toDouble();
    });
  }

  void _decrement() {
    setState(() {
      if (totalQuentityOfItems > 0) {
        totalQuentityOfItems = totalQuentityOfItems - 0.5;
        totalPrice = totalQuentityOfItems * widget.itemModel.price.toInt();
        aq = widget.itemModel.quentity.toDouble() -
            totalQuentityOfItems.toDouble();
      }
    });
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
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
            centerTitle: true,
            title: Text(
              "Product Details",
              style: TextStyle(
                  fontSize: 35.0, color: Colors.white, fontFamily: "Signatra"),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (c) => CartPage());
                        Navigator.pushReplacement(context, route);
                      }),
                  Positioned(
                    child: Stack(
                      children: [
                        Icon(
                          Icons.brightness_1,
                          size: 20.0,
                          color: Colors.green,
                        ),
                        Positioned(
                            top: 3.0,
                            bottom: 4.0,
                            left: 4.0,
                            child: Consumer<CartItemCounter>(
                              builder: (context, counter, _) {
                                return Text(
                                  (EcommerceApp.sharedPreferences
                                              .getStringList(
                                                  EcommerceApp.userCartList)
                                              .length -
                                          1)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                );
                              },
                            )),
                      ],
                    ),
                  )
                ],
              )
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (c) => StoreHome(
                          passedTitle: '${widget.itemModel.title}',
                        ));
                Navigator.pushReplacement(context, route);
              },
            ),
          ),
          //drawer: MyDrawer(),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.network(widget.itemModel.thumbnailUrl),
                        ),
                        Container(
                          color: Colors.grey[300],
                          child: SizedBox(
                            height: 1.0,
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.itemModel.shortInfo,
                                  style: boldTextStyle,
                                ),
                                Spacer(),
                                Text(
                                  widget.itemModel.status,
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Available Quentity ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '$aq' + "Kg",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text("Price (1 Kg) "),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  r"Rs " + widget.itemModel.price.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  widget.itemModel.contactNo.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                    child: Text(
                                  widget.itemModel.address,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: _decrement,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Icon(Icons.horizontal_rule))),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    '$totalQuentityOfItems',
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                    onTap: _increment,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Icon(Icons.add))),
                                Spacer(),
                                Text(
                                  'Rs $totalPrice',
                                  style: boldTextStyle,
                                ),
                              ],
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.padding,
                                color: Colors.green,
                              ),
                              title: Container(
                                width: 250.0,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.green),
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Quentity",
                                    hintStyle: TextStyle(color: Colors.green),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Chat With Seller",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (c) => SignIn(null));
                                    Navigator.pushReplacement(context, route);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border:
                                              Border.all(color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(
                                        Icons.message,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Seller Name ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Text(
                                  widget.itemModel.ename.toString(),
                                  style: TextStyle(
                                      color: Colors.green[500],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            String productId = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
                            final itemsRef =
                                Firestore.instance.collection("BuyerCart");
                            itemsRef.document(productId).setData({
                              "shortInfo": widget.itemModel.shortInfo.trim(),
                              "longDescription":
                                  widget.itemModel.longDescription.trim(),
                              "price":
                                  int.parse(widget.itemModel.price.toString()),
                              "publishedDate": DateTime.now(),
                              "status": "available",
                              "thumbnailUrl": widget.itemModel.thumbnailUrl,
                              "title": widget.itemModel.title.trim(),
                              "quentity": totalQuentityOfItems.toInt(),
                              "itemTotalAmount": totalPrice.toInt(),
                              "contactNo": widget.itemModel.contactNo,
                              "address": widget.itemModel.address,
                              "nearTown": widget.itemModel.nearestTown,
                              "productId": productId,
                              "uid": widget.itemModel.uid,
                            });
                            setState(() {
                              textEditingController.clear();
                            });

                            checkItemInCart(
                                widget.itemModel.shortInfo, context);

                            Route route = MaterialPageRoute(
                                builder: (c) => StoreHome(
                                      passedTitle: '${widget.itemModel.title}',
                                    ));
                            Navigator.pushReplacement(context, route);
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.green[900],
                                  Colors.lightGreenAccent
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width - 40.0,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "Add to Carts ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
