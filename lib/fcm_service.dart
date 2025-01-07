import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FCMService {
  static const String baseUrl = 'http://192.168.43.181:5000/api';

  static Future<void> saveTokenToServer(String token) async {
    try {
      print('Attempting to save token to server...');

      final response = await http.post(
        Uri.parse('$baseUrl/fcm/token'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'fcmToken': token}),
      );

      print('Server response status: ${response.statusCode}');
      print('Server response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Token saved successfully. Therapist ID: ${data['therapistId']}');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('therapistId', data['therapistId']);
      } else if (response.statusCode == 409) {
        print('Token already exists in database');
        final data = json.decode(response.body);
        // يمكننا هنا تحديث المعرف المحلي إذا كان التوكن موجوداً بالفعل
        if (data['therapistId'] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('therapistId', data['therapistId']);
        }
      } else {
        print('Failed to save token. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error, stackTrace) {
      print('Error saving token: $error');
      print('Stack trace: $stackTrace');
    }
  }
}
