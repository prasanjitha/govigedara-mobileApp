class CartNew {
  final String name;
  final String quentity;
  final String amount;
  final String mobileNo;
  final String id;
  final String url;
  final String nearTown;
  final String address;

  CartNew(
      {this.name,
      this.quentity,
      this.amount,
      this.mobileNo,
      this.id,
      this.address,
      this.nearTown,
      this.url});

  CartNew.fromMap(Map<String, dynamic> data, String id)
      : name = data["name"],
        quentity = data['quentity'],
        amount = data['amount'],
        mobileNo = data['mobileNo'],
        url = data['url'],
        address = data['address'],
        nearTown = data['nearTown'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "quentity": quentity,
      "amount": amount,
      "mobileNo": mobileNo,
      "url": url,
      "address": address,
      "nearTown": nearTown,
    };
  }
}
