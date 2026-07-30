import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {
  final String id;
  final String employeeId;
  final String fullName;
  final String phone;
  final String email;
  final String assignedBusId;
  final bool online;
  final bool active;
  String get name => fullName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DriverModel({
    required this.id,
    required this.employeeId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.assignedBusId,
    required this.online,
    required this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return DriverModel(
      id: id,
      employeeId: map["employeeId"] ?? "",
      fullName: map["fullName"] ?? "",
      phone: map["phone"] ?? "",
      email: map["email"] ?? "",
      assignedBusId: map["assignedBusId"] ?? "",
      online: map["online"] ?? false,
      active: map["active"] ?? true,
      createdAt: (map["createdAt"] as Timestamp?)?.toDate(),
      updatedAt: (map["updatedAt"] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "employeeId": employeeId,
      "fullName": fullName,
      "phone": phone,
      "email": email,
      "assignedBusId": assignedBusId,
      "online": online,
      "active": active,
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    };
  }

  DriverModel copyWith({
    String? employeeId,
    String? fullName,
    String? phone,
    String? email,
    String? assignedBusId,
    bool? online,
    bool? active,
  }) {
    return DriverModel(
      id: id,
      employeeId: employeeId ?? this.employeeId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      assignedBusId: assignedBusId ?? this.assignedBusId,
      online: online ?? this.online,
      active: active ?? this.active,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}