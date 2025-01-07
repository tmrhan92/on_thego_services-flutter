import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'notifications-screen.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceDescriptionController = TextEditingController();
  final TextEditingController _servicePriceController = TextEditingController();
  final TextEditingController _serviceDurationController = TextEditingController();

  String _serviceType = 'تعليم';
  String _subCategory = 'رياضيات';
  double? _latitude;
  double? _longitude;
  bool _isLoading = false;

  List<String> _getSubCategories() {
    switch (_serviceType) {
      case 'تعليم':
        return ['رياضيات', 'علوم', 'تاريخ'];
      case 'صيانة':
        return ['الكهرباء', 'السباكة', 'النجارة'];
      case 'خدمات منزلية':
        return ['تنظيف', 'حدائق', 'مكافحة الآفات', 'رعاية كبار السن', 'رعاية الأطفال'];
      case 'مساج':
        return ['مساج استرخائي', 'مساج تايلندي', 'مساج رياضي'];
      case 'المناسبات والفعاليات':
        return ['خدمات الديكور', 'خدمات التصوير', 'تنظيم الحفلات'];
      default:
        return [];
    }
  }

  void _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى تفعيل خدمات الموقع')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم رفض إذن الوصول إلى الموقع')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يمكن الوصول إلى الموقع بدون إذن')),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في الحصول على الموقع: $e')),
      );
    }
  }

  void _addService() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    String serviceName = _serviceNameController.text.trim();
    String serviceDescription = _serviceDescriptionController.text.trim();
    String servicePrice = _servicePriceController.text.trim();
    String serviceDuration = _serviceDurationController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final therapistId = prefs.getString('therapistId');

    if (therapistId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى تسجيل الدخول كمقدم خدمة (Therapist)')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (serviceName.isEmpty ||
        serviceDescription.isEmpty ||
        servicePrice.isEmpty ||
        serviceDuration.isEmpty ||
        _latitude == null ||
        _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (double.tryParse(servicePrice) == null || int.tryParse(serviceDuration) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى إدخال سعر ومدة صحيحين')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    Map<String, dynamic> serviceData = {
      'name': serviceName,
      'description': serviceDescription,
      'serviceType': _serviceType,
      'subCategory': _subCategory,
      'price': double.tryParse(servicePrice),
      'duration': int.tryParse(serviceDuration),
      'latitude': _latitude,
      'longitude': _longitude,
      'therapistId': therapistId,
    };

    try {
      await ApiService().addService(serviceData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تسجيل الخدمة بنجاح')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error while adding service: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في إضافة الخدمة: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة خدمة")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _serviceNameController,
              decoration: InputDecoration(
                labelText: "اسم الخدمة",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _serviceDescriptionController,
              decoration: InputDecoration(
                labelText: "وصف الخدمة",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _servicePriceController,
              decoration: InputDecoration(
                labelText: "سعر الخدمة",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _serviceDurationController,
              decoration: InputDecoration(
                labelText: "مدة الخدمة (بالدقائق)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _serviceType,
              onChanged: (String? newValue) {
                setState(() {
                  _serviceType = newValue!;
                  _subCategory = _getSubCategories().first;
                });
              },
              items: <String>['تعليم', 'صيانة', 'خدمات منزلية', 'مساج', 'المناسبات والفعاليات']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _subCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _subCategory = newValue!;
                });
              },
              items: _getSubCategories().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text("الحصول على الموقع الحالي"),
            ),
            SizedBox(height: 10),
            Text(
              _latitude != null && _longitude != null
                  ? "الإحداثيات: ($_latitude, $_longitude)"
                  : "لم يتم تحديد الموقع بعد",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _addService,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("إضافة الخدمة"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final userId = prefs.getString('userId');
                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(userId: userId),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى تسجيل الدخول أولاً')),
                  );
                }
              },
              child: Text("الاشعارات"),
            ),
          ],
        ),
      ),
    );
  }
}
