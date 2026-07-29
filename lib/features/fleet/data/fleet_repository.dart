import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bus_model.dart';

class FleetRepository {
  final CollectionReference<Map<String, dynamic>> _collection =
  FirebaseFirestore.instance.collection('buses');

  Future<List<BusModel>> getBuses() async {
    final snapshot = await _collection.orderBy('vehicleNumber').get();

    return snapshot.docs
        .map((doc) => BusModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> addBus(BusModel bus) async {
    // Uses the client-generated id (see AddBusDialog) as the doc ID,
    // rather than .add(), so it stays consistent with how the dialog builds it.
    await _collection.doc(bus.id).set(bus.toMap());
  }

  Future<void> updateBus(BusModel bus) async {
    await _collection.doc(bus.id).update(bus.toMap());
  }

  Future<void> deleteBus(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> assignDriver(
      String busId,
      String driverId,
      String driverName,
      ) async {
    await _collection.doc(busId).update({
      'driverId': driverId,
      'driverName': driverName,
      'updatedAt': DateTime.now(),
    });
  }

  Future<void> updateStatus(String busId, BusStatus status) async {
    await _collection.doc(busId).update({
      'status': status.name,
      'updatedAt': DateTime.now(),
    });
  }

  /// One-time helper to push the old dummy fleet into Firestore for testing.
  /// Safe to call repeatedly — it only writes docs that don't already exist.
  Future<void> seedSampleDataIfEmpty() async {
    final existing = await _collection.limit(1).get();
    if (existing.docs.isNotEmpty) return;

    final now = DateTime.now();
    final batch = FirebaseFirestore.instance.batch();

    final sampleBuses = [
      BusModel(
        id: "1",
        vehicleNumber: "EV-001",
        registration: "UBA 001A",
        capacity: 40,
        driverId: "1",
        driverName: "John Ssemanda",
        routeId: "r1",
        routeName: "Kampala → Entebbe",
        status: BusStatus.running,
        latitude: 0.3476,
        longitude: 32.5825,
        heading: 90,
        batteryLevel: 82,
        active: true,
        createdAt: now,
        updatedAt: now,
      ),
      BusModel(
        id: "2",
        vehicleNumber: "EV-007",
        registration: "UBA 007B",
        capacity: 40,
        driverId: "2",
        driverName: "Sarah Namutebi",
        routeId: "r2",
        routeName: "Ntinda → CBD",
        status: BusStatus.boarding,
        latitude: 0.3406,
        longitude: 32.6109,
        heading: 45,
        batteryLevel: 91,
        active: true,
        createdAt: now,
        updatedAt: now,
      ),
      BusModel(
        id: "3",
        vehicleNumber: "EV-011",
        registration: "UBA 011C",
        capacity: 40,
        driverId: "3",
        driverName: "Moses Okello",
        routeId: "r3",
        routeName: "Mukono → Kampala",
        status: BusStatus.offline,
        latitude: 0.3533,
        longitude: 32.7553,
        heading: 0,
        batteryLevel: 15,
        active: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];

    for (final bus in sampleBuses) {
      batch.set(_collection.doc(bus.id), bus.toMap());
    }

    await batch.commit();
  }
  void updateStatus(
      String busId,
      String status,
      ) {
    final index = _buses.indexWhere((e) => e.id == busId);

    if (index == -1) return;

    final bus = _buses[index];

    _buses[index] = BusModel(
      id: bus.id,
      vehicleNumber: bus.vehicleNumber,
      registration: bus.registration,
      driver: bus.driver,
      route: bus.route,
      capacity: bus.capacity,
      status: status,
    );
  }
}