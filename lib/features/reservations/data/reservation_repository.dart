import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/reservation_status.dart';
import '../models/reservation_model.dart';

class ReservationRepository {
  final CollectionReference<Map<String, dynamic>> _collection =
  FirebaseFirestore.instance.collection('reservations');

  Stream<List<ReservationModel>> streamReservations() {
    return _collection.orderBy('scheduledAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => ReservationModel.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addReservation(ReservationModel reservation) async {
    await _collection.doc(reservation.id).set(reservation.toMap());
  }

  Future<void> updateReservation(ReservationModel reservation) async {
    await _collection.doc(reservation.id).update(reservation.toMap());
  }

  Future<void> deleteReservation(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> updateStatus(String id, ReservationStatus status) async {
    await _collection.doc(id).update({
      "status": status.name,
      "updatedAt": Timestamp.now(),
    });
  }
}