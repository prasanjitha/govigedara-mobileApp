import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/cart.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<CartNew>> getNotes() {
    return _db.collection('customerCart').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => CartNew.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addNote(CartNew cartNew) {
    return _db.collection('customerCart').add(cartNew.toMap());
  }

  Future<void> deleteNote(String id) {
    return _db.collection('customerCart').document(id).delete();
  }

  Future<void> updateNote(CartNew cartNew) {
    return _db
        .collection('customerCart')
        .document(cartNew.id)
        .updateData(cartNew.toMap());
  }
}
