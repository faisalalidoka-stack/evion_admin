import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/route_model.dart';

class RouteRepository {
  final CollectionReference<Map<String, dynamic>> _collection =
  FirebaseFirestore.instance.collection('routes');

  Stream<List<RouteModel>> streamRoutes() {
    return _collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => RouteModel.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addRoute(RouteModel route) async {
    await _collection.doc(route.id).set(route.toMap());
  }

  Future<void> updateRoute(RouteModel route) async {
    await _collection.doc(route.id).update(route.toMap());
  }

  Future<void> deleteRoute(String id) async {
    await _collection.doc(id).delete();
  }
}