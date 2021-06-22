import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/cart.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/displayCart.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/firestore_service.dart';
import 'package:e_shop/Models/cart.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Models/newCart/models/cartModel.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Cart cart;

  final ItemModel itemModel;
  ProductPage({this.cart, this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemQuentityController = TextEditingController();
  TextEditingController _itemAddressController = TextEditingController();
  TextEditingController _itemNearestTownController = TextEditingController();
  TextEditingController _itemContactNoController = TextEditingController();
  TextEditingController _itemAmountController = TextEditingController();
  TextEditingController _itemImageUrlController = TextEditingController();

  double quantityOfItems = 0.0;
  double total = 0.0;
  double availableQuentity;
  void _increment() {
    setState(() {
      quantityOfItems = quantityOfItems + 0.25;
      total = quantityOfItems * widget.itemModel.price.toDouble();
      availableQuentity =
          widget.itemModel.quentity.toDouble() - quantityOfItems;
    });
  }

  void _decrement() {
    setState(() {
      quantityOfItems = quantityOfItems - 0.25;
      total = quantityOfItems * widget.itemModel.price.toDouble();
      availableQuentity =
          widget.itemModel.quentity.toDouble() + quantityOfItems;
    });
  }

  get isEditMote => widget.cart != null;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
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
            "govigedaras",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
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
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => StoreHome());
              Navigator.pushReplacement(context, route);
            },
          ),
        ),
        body: SafeArea(
          child: ListView(
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
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text("available Quentity: "),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(availableQuentity.toString() + " Kg"),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.itemModel.longDescription,
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Price(1 Kg)",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                        "Rs " +
                                            widget.itemModel.price.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      widget.itemModel.address,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      '',
                                      // widget.itemModel.contactNo,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: _decrement,
                                    child: Icon(Icons.horizontal_rule)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    '$quantityOfItems',
                                  ),
                                ),
                                GestureDetector(
                                    onTap: _increment, child: Icon(Icons.add)),
                                Spacer(),
                                Text(
                                  'Rs $total',
                                  style: boldTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
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
                            CartNew note = CartNew(
                              name: widget.itemModel.shortInfo,
                              quentity: quantityOfItems.toString(),
                              amount: total.toString(),
                              // mobileNo: itemcontactNo,
                              url: widget.itemModel.thumbnailUrl,
                              address: widget.itemModel.address,
                              nearTown: widget.itemModel.nearestTown,
                            );
                            Route route = MaterialPageRoute(
                                builder: (c) => displatCart());
                            Navigator.pushReplacement(context, route);
                            FirestoreService().addNote(note);
                          },

                          //onTap: () => checkItemInCart(
                          //   widget.itemModel.shortInfo, context),

                          /* onTap: () {
                            Map<String, dynamic> data = {
                              "productID": widget.itemModel.shortInfo,
                              "imgUrl": widget.itemModel.thumbnailUrl,
                              "quentityOfItem": quantityOfItems,
                              "total": total,
                              "address": widget.itemModel.address,
                            };
                            Firestore.instance.collection("byerCart").add(data);*/

                          /*Firestore.instance.collection("CartItemList").
                              add({
                                "imgUrl":widget.itemModel.thumbnailUrl,
                                "total": total,
                                "quentityOfItem": quantityOfItems,
                                "productID": widget.itemModel.shortInfo,
                                "Date": widget.itemModel.publishedDate,
                                "contactNo": widget.itemModel.contactNo,
                                "address": widget.itemModel.address,
                                "nearestTown": widget.itemModel.nearestTown,

                              });
                            Route route =
                                MaterialPageRoute(builder: (c) => myCart());
                            Navigator.pushReplacement(context, route);
                          },*/

                          child: Container(
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.green[900],
                                  Colors.lightGreenAccent[700]
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
                                "Add to Cart ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
