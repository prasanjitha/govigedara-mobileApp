import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/userCart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'afterAddingCart.dart';

class CartPage extends StatefulWidget {
  ItemModel model;
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;
  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (EcommerceApp.sharedPreferences
                    .getStringList(EcommerceApp.userCartList)
                    .length ==
                1) {
              Fluttertoast.showToast(msg: "your cart is empty");
            } else {
              Route route = MaterialPageRoute(
                  builder: (c) => Address(
                        totalAmount: totalAmount,
                      ));
              Navigator.pushReplacement(context, route);
            }
          },
          label: Text("Check Out"),
          backgroundColor: Colors.green[500],
          icon: Icon(Icons.navigate_next),
        ),
        appBar: AppBar(
          title: Text("My Cart"),
          centerTitle: true,
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
                        color: Colors.white,
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
                                    color: Colors.green,
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
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (c) => StoreHome(
                        passedTitle: 'Vegetables',
                      ));
              Navigator.pushReplacement(context, route);
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Consumer2<TotalAmount, CartItemCounter>(
                builder: (context, amountProvider, cartProvider, c) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: cartProvider.count == 0
                            ? Text(
                                "Total Price: Rs ${amountProvider.totalAmount.toString()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              )
                            : Text(
                                "Total Price: Rs ${amountProvider.totalAmount.toString()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              )),
                  );
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: EcommerceApp.firestore
                  .collection("BuyerCart")
                  .where("shortInfo",
                      whereIn: EcommerceApp.sharedPreferences
                          .getStringList(EcommerceApp.userCartList))
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : snapshot.data.documents.length == 0
                        ? beginBuildingCart()
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              CartItemModel model = CartItemModel.fromJson(
                                  snapshot.data.documents[index].data);
                              if (index == 0) {
                                totalAmount = 0;
                                totalAmount =
                                    model.quentity * model.price + totalAmount;
                              } else {
                                totalAmount =
                                    model.quentity * model.price + totalAmount;
                              }
                              if (snapshot.data.documents.length - 1 == index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((t) {
                                  Provider.of<TotalAmount>(context,
                                          listen: false)
                                      .display(totalAmount);
                                });
                              }
                              return sourceInfo(model, context,
                                  removeCartFunction: () =>
                                      removeItemFromUserCart(model.shortInfo));
                            },
                            childCount: snapshot.hasData
                                ? snapshot.data.documents.length
                                : 0,
                          ));
              },
            )
          ],
        ),
      ),
    );
  }

  beginBuildingCart() {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.insert_emoticon,
                color: Colors.white,
              ),
              Text("cart is empty"),
              Text("Start adding items to your Cart"),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId) {
    List tempCartList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(shortInfoAsId);
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Item removed cart successfully");
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
      totalAmount = 0;
    });
  }
}

Widget sourceInfo(CartItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    splashColor: Colors.pink,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [
            Image.network(
              model.thumbnailUrl,
              width: 140.0,
              height: 140.0,
            ),
            SizedBox(
              width: 14.0,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35.0,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text(model.shortInfo,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text("Quentity :"),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.quentity.toString() + " Kg",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800]),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Rs " + model.itemTotalAmount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text("Seller Mobile  :"),
                    Text(
                      model.contactNo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text("Nearest Town :"),
                    Expanded(
                        child: Text(
                      model.nearTown,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                            children: [],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Flexible(child: Container()),
                Align(
                  alignment: Alignment.centerRight,
                  child: removeCartFunction == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.pinkAccent,
                          ),
                          onPressed: () {
                            checkItemInCart(model.shortInfo, context);
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.remove_shopping_cart,
                            color: Colors.pinkAccent,
                          ),
                          onPressed: () {
                            removeCartFunction();
                            Route route = MaterialPageRoute(
                                builder: (c) => StoreHome(
                                      passedTitle: 'Vegetables',
                                    ));
                            Navigator.pushReplacement(context, route);
                          },
                        ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.pink,
                )
              ],
            ))
          ],
        ),
      ),
    ),
  );
}
