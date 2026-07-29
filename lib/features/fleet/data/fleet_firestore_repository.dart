import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bus_model.dart';

class FleetFirestoreRepository {
  FleetFirestoreRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _buses =>
      _firestore.collection('buses');

  Stream<List<BusModel>> streamBuses() {
    return _buses.snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => BusModel.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addBus(BusModel bus) async {
    await _buses.doc(bus.id).set(bus.toMap());
  }

  Future<void> updateBus(BusModel bus) async {
    await _buses.doc(bus.id).update(bus.toMap());
  }

  Future<void> deleteBus(String id) async {
    await _buses.doc(id).delete();
  }

  Future<void> updateStatus(
      String id,
      String status,
      ) async {
    await _buses.doc(id).update({
      "status": status,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}