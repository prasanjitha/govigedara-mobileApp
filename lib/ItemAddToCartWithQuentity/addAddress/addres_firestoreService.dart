import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/ItemAddToCartWithQuentity/addAddress/addres.dart';

class AddressFirestoreService {
  static final AddressFirestoreService _firestoreService =
      AddressFirestoreService._internal();
  Firestore _db = Firestore.instance;

  AddressFirestoreService._internal();

  factory AddressFirestoreService() {
    return _firestoreService;
  }

  Stream<List<Address>> getNotes() {
    return _db.collection('AddresscustomerCart').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Address.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> addNote(Address address) {
    return _db.collection('AddresscustomerCart').add(address.toMap());
  }

  Future<void> deleteNote(String id) {
    return _db.collection('AddresscustomerCart').document(id).delete();
  }

  Future<void> updateNote(Address address) {
    return _db
        .collection('AddresscustomerCart')
        .document(address.id)
        .updateData(address.toMap());
  }
}
