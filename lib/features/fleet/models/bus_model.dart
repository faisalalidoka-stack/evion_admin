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
    this.driverId = '',
    this.driverName = '',
    this.routeId = '',
    this.routeName = '',
    this.status = BusStatus.offline,
    this.latitude = 0,
    this.longitude = 0,
    this.heading = 0,
    this.batteryLevel = 0,
    this.active = true,
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
      "capacity": capacity,
      "driverId": driverId,
      "driverName": driverName,
      "routeId": routeId,
      "routeName": routeName,
      "status": status.name,
      "latitude": latitude,
      "longitude": longitude,
      "heading": heading,
      "batteryLevel": batteryLevel,
      "active": active,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory BusModel.fromMap(String id, Map<String, dynamic> map) {
    return BusModel(
      id: id,
      vehicleNumber: map["vehicleNumber"] ?? "",
      registration: map["registration"] ?? "",
      capacity: (map["capacity"] ?? 0) as int,
      driverId: map["driverId"] ?? "",
      driverName: map["driverName"] ?? "",
      routeId: map["routeId"] ?? "",
      routeName: map["routeName"] ?? "",
      status: BusStatus.values.firstWhere(
            (s) => s.name == map["status"],
        orElse: () => BusStatus.offline,
      ),
      latitude: (map["latitude"] ?? 0).toDouble(),
      longitude: (map["longitude"] ?? 0).toDouble(),
      heading: (map["heading"] ?? 0).toDouble(),
      batteryLevel: (map["batteryLevel"] ?? 0) as int,
      active: map["active"] ?? true,
      createdAt: (map["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map["updatedAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}