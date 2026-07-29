import '../../../core/constants/bus_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusModel {
  final String id;

  final String vehicleNumber;

  final String registration;

  final int capacity;

  final String driverId;

  final String driverName;

  final String routeId;

  final String routeName;

  final BusStatus status;

  final double latitude;

  final double longitude;

  final double heading;

  final int batteryLevel;

  final bool active;

  final DateTime createdAt;

  final DateTime updatedAt;

  const BusModel({
    required this.id,
    required this.vehicleNumber,
    required this.registration,
    required this.capacity,
    required this.driverId,
    required this.driverName,
    required this.routeId,
    required this.routeName,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.heading,
    required this.batteryLevel,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  BusModel copyWith({
    String? id,
    String? vehicleNumber,
    String? registration,
    int? capacity,
    String? driverId,
    String? driverName,
    String? routeId,
    String? routeName,
    BusStatus? status,
    double? latitude,
    double? longitude,
    double? heading,
    int? batteryLevel,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusModel(
      id: id ?? this.id,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      registration: registration ?? this.registration,
      capacity: capacity ?? this.capacity,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      routeId: routeId ?? this.routeId,
      routeName: routeName ?? this.routeName,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      heading: heading ?? this.heading,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "vehicleNumber": vehicleNumber,
      "registration": registration,
      "driver": driver,
      "route": route,
      "capacity": capacity,
      "status": status,
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    };
  }

  factory BusModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return BusModel(
      id: id,
      vehicleNumber: map["vehicleNumber"] ?? "",
      registration: map["registration"] ?? "",
      driver: map["driver"] ?? "",
      route: map["route"] ?? "",
      capacity: map["capacity"] ?? 0,
      status: map["status"] ?? "Offline",
    );
  }
}