import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_message.dart';
import '../models/notification.dart';
import '../models/review.dart';
import '../models/user.dart';
import '../models/therapist.dart';
import '../models/booking.dart';
import '../models/service.dart';


class ApiService {
  final String baseUrl = 'http://192.168.43.181:5000/api';

  Future<void> register(String email, String password, String name, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'name': name,
        'role': role
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('فشل في التسجيل');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return {
        'token': jsonResponse['token'],
        'role': jsonResponse['role'],
        'userId': jsonResponse['userId'].toString(), // تحويل userId إلى String
      };
    } else {
      throw Exception('فشل في تسجيل الدخول');
    }
  }


  Future<List<Therapist>> getTherapists() async {
    final response = await http.get(Uri.parse('$baseUrl/therapists'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((therapist) => Therapist.fromJson(therapist)).toList();
    } else {
      throw Exception('Failed to load therapists');
    }
  }

  Future<List<dynamic>> getNearbyServices(String serviceType, double latitude, double longitude, double radius) async {
    final url = Uri.parse('$baseUrl/services/nearby?serviceType=$serviceType&latitude=$latitude&longitude=$longitude&radius=$radius');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch nearby services');
    }
  }


  Future<String?> getTherapistFCMToken(String serviceId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/therapists/$serviceId/token'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['token'];
      } else if (response.statusCode == 404) {
        print('Therapist token not found for service ID: $serviceId');
        return null;
      } else {
        throw Exception('Failed to get therapist token: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting therapist token: $e');
      return null;
    }
  }
  Future<void> bookAppointment(String userId, String serviceId, DateTime date, String time) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'serviceId': serviceId,
          'date': date.toIso8601String(),
          'time': time,
        }),
      );

      if (response.statusCode == 201) {
        print('Appointment booked successfully');
      } else {
        throw Exception('Failed to book appointment: ${response.body}');
      }
    } catch (e) {
      print('Error booking appointment: $e');
      throw Exception('Failed to book appointment: $e');
    }
  }

  Future<void> sendTokenToServer(String? token, String therapistId) async {
    if (token == null) return;
    final response = await http.post(
      Uri.parse('$baseUrl/save-fcm-token'),
      headers: {'Content-Type': 'application/json'},

      body: jsonEncode({
        'therapistId': therapistId, // أضف الحقل المطلوب
        'fcmToken': token,
      }),

    );
    print("Server response status: ${response.statusCode}");
    print("Server response body: ${response.body}");


    if (response.statusCode == 200) {
      print('Token sent successfully.');
    } else {
      print('Failed to send token to server: ${response.body}');
    }
  }

  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notifications/$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch notifications: ${response.body}');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  Future<void> updateNotificationStatus(String notificationId, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/notifications/$notificationId/status'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update notification status: ${response.body}');
      }
    } catch (e) {
      print('Error updating notification status: $e');
      throw Exception('Failed to update notification status: $e');
    }
  }


  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('فشل في تحميل المستخدمين');
    }
  }


  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 200) {
      throw Exception('فشل في حذف المستخدم');
    }
  }

  Future<void> deleteTherapist(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/therapists/$id'));
    if (response.statusCode != 200) {
      throw Exception('فشل في حذف المعالج');
    }
  }

  Future<void> addTherapist(String name, String serviceType, String bio) async {
    final response = await http.post(
      Uri.parse('$baseUrl/therapists'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'serviceType': serviceType, 'bio': bio}),
    );

    if (response.statusCode != 201) {
      throw Exception('فشل في إضافة المعالج');
    }
  }
  Future<List<Service>> getServices() async {
    final response = await http.get(Uri.parse('$baseUrl/services'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((service) => Service.fromJson(service)).toList();
    } else {
      throw Exception('فشل في تحميل الخدمات');
    }
  }
  Future<List<Service>> getServicesOfType(String type) async {
    // تأكد من تعديل المنطق بحيث يمكن التعامل مع الفئة الفرعية
    try {
      final response = await http.get(Uri.parse('$baseUrl/services?type=$type'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((service) => Service.fromJson(service)).toList();
      } else {
        throw Exception('فشل في تحميل الخدمات');
      }
    } catch (e) {
      throw Exception('خطأ: $e');
    }
  }



  Future<void> addService(Map<String, dynamic> serviceData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/services'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(serviceData),
    );

    if (response.statusCode != 201) {
      throw Exception('فشل في إضافة الخدمة');
    }
  }

  Future<List<Review>> getTherapistReviews(String therapistId) async {
    final response = await http.get(Uri.parse('$baseUrl/reviews/$therapistId'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((review) => Review.fromJson(review)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<void> addReview(String therapistId, double rating, String comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'therapistId': therapistId,
        'rating': rating,
        'comment': comment,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add review');
    }
  }

  Future<List<dynamic>> getNearbyTherapists(double latitude, double longitude, double radius) async {
    final url = Uri.parse('$baseUrl/therapists/nearby?latitude=$latitude&longitude=$longitude&radius=$radius');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch nearby therapists');
    }
  }


  // Chat
  Future<List<ChatMessage>> getChatMessages(String userId, String therapistId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/chat/$userId/$therapistId'),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((msg) => ChatMessage.fromJson(msg)).toList();
    } else {
      throw Exception('Failed to load chat messages');
    }
  }



  Future<void> sendMessage(String senderId, String receiverId, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/send'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'senderId': senderId,
        'receiverId': receiverId,
        'content': content,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }

  // Payments
  Future<void> processPayment(String bookingId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments/process'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'bookingId': bookingId,
        'amount': amount,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Payment failed');
    }
  }


  Future<List<Service>> fetchServices() async {
    try {
      final response = await ApiService().getServices(); // تأكد من أن هذا يسترجع الخدمات بشكل صحيح
      return response; // يجب أن تعيد قائمة بالخدمات
    } catch (e) {
      throw Exception('فشل في تحميل الخدمات: $e');
    }
  }


  Future<void> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post data to $endpoint');
    }
  }
}
