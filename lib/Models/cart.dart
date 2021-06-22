import 'package:e_shop/Models/viewCart.dart';
import 'package:e_shop/mainHomePage/MainPages/TopProducts.dart';
import 'package:flutter/material.dart';


class myCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Center(
        child: FlatButton(
          child: Text("View My Cart"),
          color: Colors.purpleAccent,
          onPressed: (){
            Route route =
            MaterialPageRoute(builder: (c) =>viewCart());
            Navigator.pushReplacement(context, route);
          },
        ),
      ),

    );
  }
}
