class BusModel {
  final String id;
  final String vehicleNumber;
  final String registration;
  final String route;
  final String driver;
  final int capacity;
  final String status;

  const BusModel({
    required this.id,
    required this.vehicleNumber,
    required this.registration,
    required this.route,
    required this.driver,
    required this.capacity,
    required this.status,
  });

  BusModel copyWith({
    String? vehicleNumber,
    String? registration,
    String? route,
    String? driver,
    int? capacity,
    String? status,
  }) {
    return BusModel(
      id: id,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      registration: registration ?? this.registration,
      route: route ?? this.route,
      driver: driver ?? this.driver,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
    );
  }
}