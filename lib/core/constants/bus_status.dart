enum BusStatus {
  available,
  boarding,
  running,
  maintenance,
  offline;

  String get label {
    switch (this) {
      case BusStatus.available:
        return "Available";
      case BusStatus.boarding:
        return "Boarding";
      case BusStatus.running:
        return "Running";
      case BusStatus.maintenance:
        return "Maintenance";
      case BusStatus.offline:
        return "Offline";
    }
  }
}