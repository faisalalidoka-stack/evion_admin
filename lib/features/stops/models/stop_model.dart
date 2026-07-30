import 'package:cloud_firestore/cloud_firestore.dart';

class StopModel {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StopModel({
    required this.id,
    required this.name,
    this.address = '',
    required this.latitude,
    required this.longitude,
    this.active = true,
    required this.createdAt,
    required this.updatedAt,
  });

  StopModel copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "active": active,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory StopModel.fromMap(String id, Map<String, dynamic> map) {
    return StopModel(
      id: id,
      name: map["name"] ?? "",
      address: map["address"] ?? "",
      latitude: (map["latitude"] ?? 0).toDouble(),
      longitude: (map["longitude"] ?? 0).toDouble(),
      active: map["active"] ?? true,
      createdAt: (map["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map["updatedAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}