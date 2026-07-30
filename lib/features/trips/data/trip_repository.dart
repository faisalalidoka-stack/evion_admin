import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/trip_status.dart';
import '../models/trip_model.dart';

class TripRepository {
  final CollectionReference<Map<String, dynamic>> _collection =
  FirebaseFirestore.instance.collection('trips');

  Stream<List<TripModel>> streamTrips() {
    return _collection.orderBy('scheduledAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => TripModel.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addTrip(TripModel trip) async {
    await _collection.doc(trip.id).set(trip.toMap());
  }

  Future<void> updateTrip(TripModel trip) async {
    await _collection.doc(trip.id).update(trip.toMap());
  }

  Future<void> deleteTrip(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> updateStatus(String id, TripStatus status) async {
    final updates = <String, dynamic>{
      "status": status.name,
      "updatedAt": Timestamp.now(),
    };

    if (status == TripStatus.inProgress) {
      updates["startedAt"] = Timestamp.now();
    } else if (status == TripStatus.completed) {
      updates["completedAt"] = Timestamp.now();
    }

    await _collection.doc(id).update(updates);
  }
}