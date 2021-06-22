import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String title;
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  int price;
  int quentity;
  int totalQuentity;
  int itemTotalAmount;
  String contactNo;
  String address;
  String nearTown;

  CartItemModel(
      {this.title,
      this.shortInfo,
      this.publishedDate,
      this.thumbnailUrl,
      this.longDescription,
      this.status,
      this.quentity,
      this.itemTotalAmount,
      this.contactNo,
      this.nearTown,
      this.address,
      this.totalQuentity});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    quentity = json['quentity'];
    totalQuentity = json['totalQuentity'];
    itemTotalAmount = json['itemTotalAmount'];
    contactNo = json['contactNo'];
    address = json['address'];
    nearTown = json['nearTown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    data['quentity'] = this.quentity;
    data['totalQuentity'] = this.totalQuentity;
    data['itemTotalAmount'] = this.itemTotalAmount;
    data['contactNo'] = this.contactNo;
    data['address'] = this.address;
    data['nearTown'] = this.nearTown;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
