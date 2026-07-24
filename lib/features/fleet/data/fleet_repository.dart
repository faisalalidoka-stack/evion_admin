import '../models/bus_model.dart';

class FleetRepository {
  final List<BusModel> _buses = [
    const BusModel(
      id: "1",
      vehicleNumber: "EV-001",
      registration: "UBA 001A",
      route: "Kampala → Entebbe",
      driver: "John",
      capacity: 40,
      status: "Running",
    ),
    const BusModel(
      id: "2",
      vehicleNumber: "EV-007",
      registration: "UBA 007B",
      route: "Ntinda → CBD",
      driver: "Sarah",
      capacity: 40,
      status: "Boarding",
    ),
    const BusModel(
      id: "3",
      vehicleNumber: "EV-011",
      registration: "UBA 011C",
      route: "Mukono → Kampala",
      driver: "Moses",
      capacity: 40,
      status: "Offline",
    ),
  ];

  List<BusModel> getBuses() {
    return List.from(_buses);
  }

  void deleteBus(String id) {
    _buses.removeWhere((e) => e.id == id);
  }

  void addBus(BusModel bus) {
    _buses.add(bus);
  }
}