import 'package:e_shop/mainHomePage/mainHomePage.dart';
import 'package:e_shop/q&a/orderOperations/add_order.dart';
import 'package:e_shop/q&a/orderOperations/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chooseOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Dialog(
          backgroundColor: Colors.blue[100],
          child: Container(
            width: 100,
            height: 300,
            color: Colors.green[100],
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Choose option",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      height: 20.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddNotePage()));
                      },
                      child: Text("Add Another Feedback",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.green)),
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: Text("View Your Feedback",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.green)),
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainHomePage()));
                      },
                      child: Text("Cancel",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.green)),
                    ),
                    Divider(
                      height: 1.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
