enum ReservationStatus {
  confirmed,
  cancelled,
  completed;

  String get label {
    switch (this) {
      case ReservationStatus.confirmed:
        return "Confirmed";
      case ReservationStatus.cancelled:
        return "Cancelled";
      case ReservationStatus.completed:
        return "Completed";
    }
  }
}