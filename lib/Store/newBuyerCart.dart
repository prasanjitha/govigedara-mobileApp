import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/afterAddingCart.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_shop/mainHomePage/MainPages/sellerUploadItems.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';

double width;

class SellerItem extends StatefulWidget {
  @override
  _SellerItemState createState() => _SellerItemState();
}

class _SellerItemState extends State<SellerItem> {
  Stream<QuerySnapshot> getData() async* {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    yield* Firestore.instance
        .collection('BuyerCart')
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
    return SafeArea(
      child: Scaffold(
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
            "Clear Cart Before Adding Items ",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (c) => StoreHome(
                          passedTitle: 'Vegetables',
                        ));
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
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context);
                        },
                        itemCount: dataSnapshot.data.documents.length,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.pink,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 150.0,
        width: width,
        child: Row(
          children: [
            Image.network(
              model.thumbnailUrl, //item image
              width: 140.0,
              height: 140.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(model.shortInfo, //item name
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(model.title, //item categeory
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(model.address,
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0)),
                      ),
                    ],
                  ),
                ),
                Flexible(child: Container()),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.delete_sweep_outlined,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          Firestore.instance
                              .collection("BuyerCart")
                              .document(model.productId)
                              .delete()
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: "Item Successfully Removed !");
                          });
                        })),
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
