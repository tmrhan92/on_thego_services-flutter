
import '../models/service.dart'; // تأكد من المسار الصحيح

class NotificationModel {
  final String id;
  final String userId;
  final String bookingId;
  final String message;
  final String status;
  final Service? serviceDetails; // تفاصيل الخدمة

  NotificationModel({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.message,
    required this.status,
    this.serviceDetails,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      userId: json['userId'],
      bookingId: json['bookingId'],
      message: json['message'],
      status: json['status'],
      serviceDetails: json['serviceDetails'] != null ? Service.fromJson(json['serviceDetails']) : null,
    );
  }
}