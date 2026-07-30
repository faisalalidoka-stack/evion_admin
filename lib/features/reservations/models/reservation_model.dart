import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/reservation_status.dart';

class ReservationModel {
  final String id;
  final String tripId;
  final String vehicleNumber;
  final String driverName;
  final String routeName;
  final DateTime scheduledAt;
  final String passengerName;
  final String passengerPhone;
  final int seatCount;
  final ReservationStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReservationModel({
    required this.id,
    required this.tripId,
    required this.vehicleNumber,
    required this.driverName,
    required this.routeName,
    required this.scheduledAt,
    required this.passengerName,
    required this.passengerPhone,
    this.seatCount = 1,
    this.status = ReservationStatus.confirmed,
    required this.createdAt,
    required this.updatedAt,
  });

  ReservationModel copyWith({
    String? id,
    String? tripId,
    String? vehicleNumber,
    String? driverName,
    String? routeName,
    DateTime? scheduledAt,
    String? passengerName,
    String? passengerPhone,
    int? seatCount,
    ReservationStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      driverName: driverName ?? this.driverName,
      routeName: routeName ?? this.routeName,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      passengerName: passengerName ?? this.passengerName,
      passengerPhone: passengerPhone ?? this.passengerPhone,
      seatCount: seatCount ?? this.seatCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "tripId": tripId,
      "vehicleNumber": vehicleNumber,
      "driverName": driverName,
      "routeName": routeName,
      "scheduledAt": Timestamp.fromDate(scheduledAt),
      "passengerName": passengerName,
      "passengerPhone": passengerPhone,
      "seatCount": seatCount,
      "status": status.name,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory ReservationModel.fromMap(String id, Map<String, dynamic> map) {
    return ReservationModel(
      id: id,
      tripId: map["tripId"] ?? "",
      vehicleNumber: map["vehicleNumber"] ?? "",
      driverName: map["driverName"] ?? "",
      routeName: map["routeName"] ?? "",
      scheduledAt:
      (map["scheduledAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      passengerName: map["passengerName"] ?? "",
      passengerPhone: map["passengerPhone"] ?? "",
      seatCount: (map["seatCount"] ?? 1) as int,
      status: ReservationStatus.values.firstWhere(
            (s) => s.name == map["status"],
        orElse: () => ReservationStatus.confirmed,
      ),
      createdAt: (map["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map["updatedAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}