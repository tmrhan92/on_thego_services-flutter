class Booking {
  final String userId;
  final String serviceId;
  final DateTime date;
  final String time;

  Booking({
    required this.userId,
    required this.serviceId,
    required this.date,
    required this.time,
  });

  // تحويل Booking إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'date': date.toIso8601String(),
      'time': time,
    };
  }
}