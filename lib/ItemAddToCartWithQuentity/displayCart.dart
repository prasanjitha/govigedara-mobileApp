import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/AddOrdersSystem/model/note.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/addAddress.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/cart.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/firestore_service.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';

class displatCart extends StatefulWidget {
  final CartNew cart;

  final CartNew itemModel;
  displatCart({this.cart, this.itemModel});
  @override
  _displatCartState createState() => _displatCartState();
}

class _displatCartState extends State<displatCart> {
  double price = 0;

  double quantityOfItems = 0.0;
  String total;
  double availableQuentity;
  void _increment() {
    setState(() {
      total = total + widget.itemModel.amount.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: [
            FloatingActionButton.extended(
                backgroundColor: Colors.green[300],
                onPressed: () {
                  _increment();
                },
                label: Text('Total  ' + 'Rs ' + total.toString())),
            Spacer(),
            FloatingActionButton.extended(
                backgroundColor: Colors.pink,
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (c) => AddNotePage());
                  Navigator.pushReplacement(context, route);
                },
                label: Text('Check Out')),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<CartNew>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              CartNew note = snapshot.data[index];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.green)),
                    child: Row(
                      children: [
                        Image.network(
                          note.url,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 5.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Name: "),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      note.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Quentity: ",
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              note.quentity,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              " Kg",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Text("Price: "),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rs ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      note.amount,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location:"),
                                Text(
                                  note.nearTown,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteNote(context, note.id),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              /* ListTile(
                title: Image.network(note.url),
                subtitle: Text(note.quentity),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.edit),
                      // onPressed: () => Navigator.push(context, MaterialPageRoute(
                      //   builder: (_) => AddNotePage(note: note),
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(context, note.id),
                    ),
                  ],
                ),
                //  onTap: ()=>Navigator.push(
                //   context, MaterialPageRoute(
                //  builder: (_) => NoteDetailsPage(note: note,),
                //  ),
                //   ),
              ); */
            },
          );
        },
      ),
    );
  }

  void _deleteNote(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteNote(id);
      } catch (e) {
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
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
