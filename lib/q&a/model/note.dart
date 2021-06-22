class Note {
  final String title;
  final String description;
  final String location;
  final String mobileNo;
  final String id;

  Note({this.title, this.description, this.location, this.mobileNo, this.id});

  Note.fromMap(Map<String, dynamic> data, String id)
      : title = data["title"],
        description = data['description'],
        location = data['location'],
        mobileNo = data['mobileNo'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "location": location,
      "mobileNo": mobileNo,
    };
  }
}
