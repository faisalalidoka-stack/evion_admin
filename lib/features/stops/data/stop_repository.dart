import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/stop_model.dart';

class StopRepository {
  final CollectionReference<Map<String, dynamic>> _collection =
  FirebaseFirestore.instance.collection('stops');

  Stream<List<StopModel>> streamStops() {
    return _collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => StopModel.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addStop(StopModel stop) async {
    await _collection.doc(stop.id).set(stop.toMap());
  }

  Future<void> updateStop(StopModel stop) async {
    await _collection.doc(stop.id).update(stop.toMap());
  }

  Future<void> deleteStop(String id) async {
    await _collection.doc(id).delete();
  }
}