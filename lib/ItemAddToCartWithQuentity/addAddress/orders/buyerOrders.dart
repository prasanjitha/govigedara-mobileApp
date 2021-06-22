import 'package:flutter/material.dart';

import '../addAddress.dart';

class myOrders extends StatefulWidget {
  @override
  _myOrdersState createState() => _myOrdersState();
}

class _myOrdersState extends State<myOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            //  Route route = MaterialPageRoute(builder: (c) => addAddress());
            //  Navigator.pushReplacement(context, route);
          },
        ),
      ),
    );
  }
}
