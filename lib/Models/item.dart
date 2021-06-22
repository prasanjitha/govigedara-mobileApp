// import 'package:cloud_firestore/cloud_firestore.dart';

// class ItemModel {
//   String title;
//   String shortInfo;
//   Timestamp publishedDate;
//   String thumbnailUrl;
//   String longDescription;
//   String status;
//   int price;
//   int quentity;
//   String nearestTown;
//   String address;
//   String contactNo;
//   String uid;
//   String productId;
//   String ename;

//   ItemModel({
//     this.title,
//     this.shortInfo,
//     this.publishedDate,
//     this.thumbnailUrl,
//     this.longDescription,
//     this.status,
//     this.price,
//     this.nearestTown,
//     this.quentity,
//     this.address,
//     this.contactNo,
//     this.uid,
//     this.productId,
//     this.ename,
//   });

//   ItemModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     shortInfo = json['shortInfo'];
//     publishedDate = json['publishedDate'];
//     thumbnailUrl = json['thumbnailUrl'];
//     longDescription = json['longDescription'];
//     status = json['status'];
//     price = json['price'];
//     nearestTown = json['nearestTown'];
//     quentity = json['quentity'];
//     address = json['address'];
//     contactNo = json['contactNo'];
//     productId = json['productId'];
//     uid = json['uid'];
//     ename = json['ename'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['shortInfo'] = this.shortInfo;
//     data['price'] = this.price;
//     data['quentity'] = this.quentity;
//     data['nearestTown'] = this.nearestTown;
//     data['address'] = this.address;
//     data['contactNo'] = this.contactNo;
//     data['productId'] = this.productId;
//     data['uid'] = this.uid;
//     data['ename'] = this.ename;
//     if (this.publishedDate != null) {
//       data['publishedDate'] = this.publishedDate;
//     }
//     data['thumbnailUrl'] = this.thumbnailUrl;
//     data['longDescription'] = this.longDescription;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class PublishedDate {
//   String date;

//   PublishedDate({this.date});

//   PublishedDate.fromJson(Map<String, dynamic> json) {
//     date = json['$date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['$date'] = this.date;
//     return data;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String title;
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  int price;
  int quentity;
  String nearestTown;
  String address;
  String contactNo;
  String uid;
  String productId;
  String ename;

  ItemModel(
      {this.title,
      this.shortInfo,
      this.publishedDate,
      this.thumbnailUrl,
      this.longDescription,
      this.status,
      this.price,
      this.nearestTown,
      this.quentity,
      this.address,
      this.contactNo,
      this.uid,
      this.productId,
      this.ename});

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    nearestTown = json['nearestTown'];
    quentity = json['quentity'];
    address = json['address'];
    contactNo = json['contactNo'];
    uid = json['uid'];
    productId = json['productId'];
    ename = json['ename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    data['quentity'] = this.quentity;
    data['nearestTown'] = this.nearestTown;
    data['address'] = this.address;
    data['contactNo'] = this.contactNo;
    data['ename'] = this.ename;
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
