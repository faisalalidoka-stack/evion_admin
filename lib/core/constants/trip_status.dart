enum TripStatus {
  scheduled,
  inProgress,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case TripStatus.scheduled:
        return "Scheduled";
      case TripStatus.inProgress:
        return "In Progress";
      case TripStatus.completed:
        return "Completed";
      case TripStatus.cancelled:
        return "Cancelled";
    }
  }
}