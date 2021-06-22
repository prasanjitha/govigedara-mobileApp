
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/mainHomePage/MainPages/TopProducts.dart';

import '../Models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Models/carts.dart';
import 'package:flutter/material.dart';

class viewCart extends StatefulWidget {
  @override
  _viewCartState createState() => _viewCartState();
}

class _viewCartState extends State<viewCart> {
  CartModel model=new CartModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Route route =MaterialPageRoute(builder: (c)=>StoreHome());
            Navigator.pushReplacement(context, route);
          },

        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('byerCart').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(!snapshot.hasData){
            return Text("No Item In the Cart");
          }
          return ListView(
            children: snapshot.data.documents.map((document){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(document['quentityOfItem'].toString()),
                    Text(document['total'].toString()),
                    Text(document['productID'].toString()),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                     // onPressed: () => _deleteNote(context, cart.id),
                    ),
                   SizedBox(height: 20.0,),

                   Divider(height: 2.0,color: Colors.red,)

                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _deleteNote(BuildContext context,String id) async {
    if(await _showConfirmationDialog(context)) {
      try {

      }catch(e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          content: Text("Are you sure you want to delete?"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.red,
              child: Text("Delete"),
              onPressed: () => Navigator.pop(context,true),
            ),
            FlatButton(
              textColor: Colors.black,
              child: Text("No"),
              onPressed: () => Navigator.pop(context,false),
            ),
          ],
        )
    );
  }
}
