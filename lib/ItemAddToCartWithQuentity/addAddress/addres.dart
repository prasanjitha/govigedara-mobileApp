class Address {
  final String name;
  final String id;
  final String address;

  Address({
    this.name,
    this.id,
    this.address,
  });

  Address.fromMap(Map<String, dynamic> data, String id)
      : name = data["name"],
        address = data['address'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
    };
  }
}
