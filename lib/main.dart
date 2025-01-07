import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:services_app/models/service.dart'; // Add this import
import 'package:services_app/screens/ReviewsScreen.dart';
import 'package:services_app/screens/add_service_screen.dart';
import 'package:services_app/screens/chat_screen.dart';
import 'package:services_app/screens/login/sign_in_screen.dart';
import 'package:services_app/screens/main_screen.dart';
import 'package:services_app/screens/register_screen.dart';
import 'package:services_app/screens/service_booking_screen.dart';
import 'package:services_app/screens/services_category_screen.dart';
import 'package:services_app/screens/splash_screen.dart';
import 'fcm_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'admin/admin_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');

    String? token = await messaging.getToken();
    if (token != null) {
      print("FCM Token: $token");
      await FCMService.saveTokenToServer(token);
    }

    // استمع للتغييرات في التوكن
    messaging.onTokenRefresh.listen((String newToken) {
      print('Token refreshed: $newToken');
      FCMService.saveTokenToServer(newToken);
    });

    // استقبال الإشعارات
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received notification:");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
    });
  }

  runApp(MyApp(fcmToken: '',));
}

Future<void> sendTokenToServer(String token) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.43.181:5000/api/save-fcm-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'therapistId': 'THERAPIST_ID', 'fcmToken': token}),
    );

    if (response.statusCode == 200) {
      print('Token sent successfully to server.');
    } else {
      print('Failed to send token to server: ${response.body}');
    }
  } catch (e) {
    print('Error sending token to server: $e');
  }
}

class MyApp extends StatelessWidget {
  final String? fcmToken;

  MyApp({required this.fcmToken});

  @override
  Widget build(BuildContext context) {
    print("FCM Token in MyApp: $fcmToken");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Massage App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signinscreen': (context) => SignInScreen(),
        '/': (context) => SplashScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => MainScreen(),
        '/services': (context) => ServicesCategoryScreen(),
        '/addService': (context) => AddServiceScreen(),
        '/reviews': (context) => ReviewsScreen(
          therapistId: '',
        ),
        '/chat': (context) => ChatScreen(),
        '/serviceBooking': (context) => ServiceBookingScreen(
          service: ModalRoute.of(context)!.settings.arguments as Service,
        ),
      },
    );
  }
}
