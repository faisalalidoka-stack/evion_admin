import '../models/driver_model.dart';

class DriverRepository {
  final List<DriverModel> _drivers = [
    DriverModel(
      id: "1",
      name: "John Ssemanda",
      phone: "0700000001",
      assigned: false,
    ),
    DriverModel(
      id: "2",
      name: "Sarah Namutebi",
      phone: "0700000002",
      assigned: false,
    ),
    DriverModel(
      id: "3",
      name: "David Kato",
      phone: "0700000003",
      assigned: true,
    ),
  ];

  List<DriverModel> getAvailableDrivers() {
    return _drivers.where((e) => !e.assigned).toList();
  }
}