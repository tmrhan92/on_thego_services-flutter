import 'package:flutter/material.dart';
import 'package:services_app/common/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/color_extension.dart';
import '../models/service.dart';
import '../services/api_service.dart';
import 'message/chat_message_screen.dart';

import 'message/chat_message_screen.dart';

class ServiceBookingScreen extends StatefulWidget {
  final Service service;

  ServiceBookingScreen({required this.service});

  @override
  _ServiceBookingScreenState createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = "${picked.hour}:${picked.minute}";
      });
    }
  }

// In ServiceBookingScreen
  void _bookService() async {
    if (_dateController.text.isEmpty || _timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء اختيار التاريخ والوقت')),
      );
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('يرجى تسجيل الدخول')),
        );
        return;
      }

      final serviceId = widget.service.id; // استخدام serviceId من الخدمة المحددة

      await ApiService().bookAppointment(
        userId,
        serviceId,
        DateTime.parse(_dateController.text),
        _timeController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حجز الموعد بنجاح')),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في حجز الموعد: $e')),
      );
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حجز ${widget.service.name}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(widget.service.description),
                    SizedBox(height: 8),
                    Text('السعر: ${widget.service.price} دينار'),
                    Text('المدة: ${widget.service.duration} دقيقة'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('اختر موعد الحجز:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'التاريخ',
                  border: OutlineInputBorder(),
                ),
                child: Text(_dateController.text.isEmpty ? 'اختر التاريخ' : _dateController.text),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () => _selectTime(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'الوقت',
                  border: OutlineInputBorder(),
                ),
                child: Text(_timeController.text.isEmpty ? 'اختر الوقت' : _timeController.text),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookService,
              child: Text('تأكيد الحجز'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            TextButton(
              onPressed: () {
                context.push(const ChatMessageScreen());
              },
              child: Text(
                "Chat with me |",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// إضافة الــ extension
extension TimeOfDayExtension on TimeOfDay {
  DateTime toDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}