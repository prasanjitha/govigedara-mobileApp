class Cart {
  final double quentity;
  final String name;
  final String id;

  Cart({this.quentity,this.name, this.id});

  Cart.fromMap(Map<String,dynamic> data, String id):
        name=data["name"],
        quentity=data['quentity'],
        id=id;

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "quentity":quentity,

    };
  }

}