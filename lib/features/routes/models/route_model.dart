import 'package:cloud_firestore/cloud_firestore.dart';

class RouteModel {
  final String id;
  final String name;
  final String code;
  final List<String> stopIds;
  final double distanceKm;
  final int estimatedDurationMinutes;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RouteModel({
    required this.id,
    required this.name,
    this.code = '',
    this.stopIds = const [],
    this.distanceKm = 0,
    this.estimatedDurationMinutes = 0,
    this.active = true,
    required this.createdAt,
    required this.updatedAt,
  });

  RouteModel copyWith({
    String? id,
    String? name,
    String? code,
    List<String>? stopIds,
    double? distanceKm,
    int? estimatedDurationMinutes,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RouteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      stopIds: stopIds ?? this.stopIds,
      distanceKm: distanceKm ?? this.distanceKm,
      estimatedDurationMinutes:
      estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "code": code,
      "stopIds": stopIds,
      "distanceKm": distanceKm,
      "estimatedDurationMinutes": estimatedDurationMinutes,
      "active": active,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory RouteModel.fromMap(String id, Map<String, dynamic> map) {
    return RouteModel(
      id: id,
      name: map["name"] ?? "",
      code: map["code"] ?? "",
      stopIds: List<String>.from(map["stopIds"] ?? const []),
      distanceKm: (map["distanceKm"] ?? 0).toDouble(),
      estimatedDurationMinutes:
      (map["estimatedDurationMinutes"] ?? 0) as int,
      active: map["active"] ?? true,
      createdAt: (map["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map["updatedAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}