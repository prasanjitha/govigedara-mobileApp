import 'package:e_shop/AddOrdersSystem/model/note.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/addres.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/addres_firestoreService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Orders'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: AddressFirestoreService().getNotes(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Address>> snapshot) {
                if (snapshot.hasError || !snapshot.hasData)
                  return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Address note = snapshot.data[index];
                    return ListTile(
                      title: Text(note.name),
                      subtitle: Text(note.address),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            color: Colors.blue,
                            icon: Icon(Icons.edit),
                            // onPressed: () => Navigator.push(context, MaterialPageRoute(
                            //  builder: (_) => AddNotePage(note: note),
                            // )),
                          ),
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteNote(context, note.id),
                          ),
                        ],
                      ),
                      // onTap: ()=>Navigator.push(
                      // context, MaterialPageRoute(
                      // builder: (_) => NoteDetailsPage(note: note,),
                      // ),
                      // ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await AddressFirestoreService().deleteNote(id);
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
