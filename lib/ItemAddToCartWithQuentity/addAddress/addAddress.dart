/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'orders/buyerOrders.dart';
import 'orders/deliverOrder.dart';

class addAddress extends StatefulWidget {
  @override
  _addAddressState createState() => _addAddressState();
}

class _addAddressState extends State<addAddress> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  String name;
  String address;
  getName(name) {
    this.name = name;
  }

  getAddress(address) {
    this.address = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
        centerTitle: true,
      ),
      body: Form(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameTextEditingController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                labelText: 'Name',
                icon: Icon(Icons.panorama_fish_eye_outlined),
              ),
              onChanged: (String name) {
                getName(name);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: addressTextEditingController,
              decoration: InputDecoration(
                hintText: 'Enter Address',
                labelText: 'Address',
                icon: Icon(Icons.panorama_fish_eye_outlined),
              ),
              onChanged: (String address) {
                getAddress(address);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {
                DocumentReference documentReference = Firestore.instance
                    .collection('buyerAddress')
                    .document(name);

                Map<String, dynamic> buyers = {
                  "buyerName": name,
                  "address": address,
                };
                documentReference.setData(buyers).whenComplete(() {
                  print("$name  address saved");
                });
              },
              child: Text("Submit"),
              color: Colors.green,
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => myOrders());
                Navigator.pushReplacement(context, route);
              },
              child: Text("My Orders"),
              color: Colors.amber,
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => deliverOrder());
                Navigator.pushReplacement(context, route);
              },
              child: Text("Deliver Orders"),
              color: Colors.amber,
            ),
            RaisedButton(
              onPressed: () {
                DocumentReference documentReference = Firestore.instance
                    .collection('buyerAddress')
                    .document(name);

                documentReference.get().then((value) {
                  print(value.data["address"]);
                });
              },
              child: Text("presed"),
              color: Colors.blue,
            ),
            StreamBuilder(
              stream:
                  Firestore.instance.collection("'buyerAddress").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[index];
                      return Row(
                        children: [
                          Expanded(
                              child: Text(
                            documentSnapshot["address"],
                            style: TextStyle(color: Colors.red),
                          )),
                          Expanded(
                              child: Text(
                            documentSnapshot["buyerName"],
                            style: TextStyle(color: Colors.red),
                          )),
                        ],
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
 */

import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/addres.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/addres_firestoreService.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/orders/deliverOrder.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  final Address address;

  const AddNotePage({Key key, this.address}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _locationController;
  TextEditingController _mobileNoController;
  TextEditingController _expDateController;
  FocusNode _descriptionNode;
  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMote ? widget.address.address : '');
    _locationController =
        TextEditingController(text: isEditMote ? widget.address.name : '');

    _descriptionNode = FocusNode();
  }

  get isEditMote => widget.address != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Change Order' : 'Add Order'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Name cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Name ",
                  hintText: "eg: Kasun",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _mobileNoController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "mobile",
                  hintText: "076 8975463",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "Order List",
                  hintText:
                      "   Order List\n\nleeks - 10kg\nbeet root - 15kg\nonion - 20kg\ntomato - 20kg",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _locationController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Address",
                  hintText: "No:456/A maharama mawatha,colombo",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _expDateController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Date to be Recieved",
                  hintText: "16/04/2021",
                  border: OutlineInputBorder(),
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditMote ? "Update" : "Save"),
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    try {
                      if (isEditMote) {
                        Address note = Address(
                          name: _locationController.text,
                          address: _titleController.text,
                          id: widget.address.id,
                        );
                        await AddressFirestoreService().updateNote(note);
                      } else {
                        Address note = Address(
                          name: _locationController.text,
                          address: _titleController.text,
                        );
                        await AddressFirestoreService().addNote(note);
                        Route route =
                            MaterialPageRoute(builder: (c) => HomePage());
                        Navigator.pushReplacement(context, route);
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
