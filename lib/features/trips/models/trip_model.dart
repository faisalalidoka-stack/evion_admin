import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/trip_status.dart';

class TripModel {
  final String id;
  final String busId;
  final String vehicleNumber;
  final String driverId;
  final String driverName;
  final String routeId;
  final String routeName;
  final TripStatus status;
  final DateTime scheduledAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TripModel({
    required this.id,
    required this.busId,
    required this.vehicleNumber,
    required this.driverId,
    required this.driverName,
    required this.routeId,
    required this.routeName,
    this.status = TripStatus.scheduled,
    required this.scheduledAt,
    this.startedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  TripModel copyWith({
    String? id,
    String? busId,
    String? vehicleNumber,
    String? driverId,
    String? driverName,
    String? routeId,
    String? routeName,
    TripStatus? status,
    DateTime? scheduledAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripModel(
      id: id ?? this.id,
      busId: busId ?? this.busId,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      routeId: routeId ?? this.routeId,
      routeName: routeName ?? this.routeName,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "busId": busId,
      "vehicleNumber": vehicleNumber,
      "driverId": driverId,
      "driverName": driverName,
      "routeId": routeId,
      "routeName": routeName,
      "status": status.name,
      "scheduledAt": Timestamp.fromDate(scheduledAt),
      "startedAt": startedAt != null ? Timestamp.fromDate(startedAt!) : null,
      "completedAt": completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory TripModel.fromMap(String id, Map<String, dynamic> map) {
    return TripModel(
      id: id,
      busId: map["busId"] ?? "",
      vehicleNumber: map["vehicleNumber"] ?? "",
      driverId: map["driverId"] ?? "",
      driverName: map["driverName"] ?? "",
      routeId: map["routeId"] ?? "",
      routeName: map["routeName"] ?? "",
      status: TripStatus.values.firstWhere(
            (s) => s.name == map["status"],
        orElse: () => TripStatus.scheduled,
      ),
      scheduledAt:
      (map["scheduledAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      startedAt: (map["startedAt"] as Timestamp?)?.toDate(),
      completedAt: (map["completedAt"] as Timestamp?)?.toDate(),
      createdAt: (map["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map["updatedAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}