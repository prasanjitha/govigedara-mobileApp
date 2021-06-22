import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/q&a/chooseOption/chooseOption.dart';
import 'package:e_shop/q&a/firestore_service.dart';
import 'package:e_shop/q&a/model/note.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AddNotePage extends StatefulWidget {
  final Note note;

  const AddNotePage({Key key, this.note}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _locationController;
  TextEditingController _mobileNoController;
  TextEditingController _datetime;
  FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMote ? widget.note.title : '');
    _locationController =
        TextEditingController(text: isEditMote ? widget.note.location : '');
    _mobileNoController =
        TextEditingController(text: isEditMote ? widget.note.mobileNo : '');
    _descriptionController =
        TextEditingController(text: isEditMote ? widget.note.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditMote => widget.note != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Change Your FeedBack' : 'Add Your FeedBack'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => MyDrawer());
            Navigator.pushReplacement(context, route);
          },
        ),
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
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Email is Required';
                  }

                  if (!RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(value)) {
                    return 'Please enter a valid email Address';
                  }

                  return null;
                },
                controller: _mobileNoController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "testing123@gmail.com",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "Comment",
                  hintText: "Type Your Idea...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _locationController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Question",
                  hintText: "Type Here...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(isEditMote ? "Update" : "Save"),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      try {
                        if (isEditMote) {
                          Note note = Note(
                            description: _descriptionController.text,
                            title: _titleController.text,
                            location: _locationController.text,
                            mobileNo: _mobileNoController.text,
                            id: widget.note.id,
                          );
                          await FirestoreService().updateNote(note);
                        } else {
                          Note note = Note(
                            description: _descriptionController.text,
                            title: _titleController.text,
                            location: _locationController.text,
                            mobileNo: _mobileNoController.text,
                          );
                          await FirestoreService().addNote(note);
                        }
                        Route route =
                            MaterialPageRoute(builder: (c) => chooseOption());
                        Navigator.pushReplacement(context, route);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  "Add your feedback & after that you can change or delete your feedback.  Thank You!"),
              SizedBox(
                height: 5.0,
              ),
              // ignore: deprecated_member_use
              Center(
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (c) => HomePage());
                    Navigator.pushReplacement(context, route);
                  },
                  color: Colors.green,
                  child: Text(
                    "View FeedBack",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
