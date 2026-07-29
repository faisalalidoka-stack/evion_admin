import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/driver_model.dart';

class DriverRepository {
  DriverRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _drivers =>
      _firestore.collection("drivers");

  Stream<List<DriverModel>> streamDrivers() {
    return _drivers.snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => DriverModel.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addDriver(DriverModel driver) {
    return _drivers.doc(driver.id).set(driver.toMap());
  }

  Future<void> updateDriver(DriverModel driver) {
    return _drivers.doc(driver.id).update(driver.toMap());
  }

  Future<void> deleteDriver(String id) {
    return _drivers.doc(id).delete();
  }
}