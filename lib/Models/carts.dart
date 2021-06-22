import 'package:cloud_firestore/cloud_firestore.dart';
class CartModel {
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  double total;
  double quentityOfItem;
  String nearestTown;
  String address;
  String contactNo;

  CartModel(
      {
        this.shortInfo,
        this.publishedDate,
        this.thumbnailUrl,
        this.total,
        this.nearestTown,
        this.quentityOfItem,
        this.address,
        this.contactNo,
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    total = json['total'];
    nearestTown=json['nearestTown'];
    quentityOfItem=json['quentityOf Item'];
    address=json['address'];
    contactNo=json['contactNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shortInfo'] = this.shortInfo;
    data['total'] = this.total;
    data['quentityOfItem']=this.quentityOfItem;
    data['nearestTown']=this.nearestTown;
    data['address']=this.address;
    data['contactNo']=this.contactNo;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}