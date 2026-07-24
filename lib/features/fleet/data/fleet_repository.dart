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
  void updateBus(BusModel updatedBus) {
    final index = _buses.indexWhere((e) => e.id == updatedBus.id);

    if (index == -1) return;

    _buses[index] = updatedBus;
  }
  void assignDriver(
      String busId,
      String driverId,
      String driverName,
      ) {
    final index = _buses.indexWhere((e) => e.id == busId);

    if (index == -1) return;

    final bus = _buses[index];

    _buses[index] = BusModel(
      id: bus.id,
      vehicleNumber: bus.vehicleNumber,
      registration: bus.registration,
      route: bus.route,
      capacity: bus.capacity,
      status: bus.status,
      driverId: driverId,
      driver: driverName,
    );
  }
}