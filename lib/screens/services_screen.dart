import 'package:flutter/material.dart';
import 'package:services_app/screens/service_booking_screen.dart';
import '../models/service.dart';
import '../services/api_service.dart';

class ServicesListScreen extends StatelessWidget {
  final String serviceType;

  ServicesListScreen({required this.serviceType});

  Future<List<Service>> fetchServices() async {
    try {
      final response = await ApiService().getServicesOfType(serviceType);
      return response;
    } catch (e) {
      throw Exception('فشل في تحميل الخدمات: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الخدمات المتاحة"),
      ),
      body: ServicesList(serviceType: serviceType),
    );
  }
}

class ServicesList extends StatelessWidget {
  final String serviceType; // الفئة الرئيسية مع الفئة الفرعية

  ServicesList({required this.serviceType});

  Future<List<Service>> fetchServices() async {
    try {
      final response = await ApiService().getServicesOfType(serviceType);
      return response;
    } catch (e) {
      throw Exception('فشل في تحميل الخدمات: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
      future: fetchServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // المربع الدائري أثناء التحميل
        } else if (snapshot.hasError) {
          return Center(child: Text("خطأ: ${snapshot.error}")); // إذا كان هناك خطأ أثناء التحميل
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("لا توجد خدمات متاحة")); // إذا لم يكن هناك خدمات
        } else {
          final services = snapshot.data!;
          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];

              return Card( // استخدام Card لإعطاء خدمات مظهر جذاب
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: ListTile(
                  // مكان الصورة في حالة عدم وجودها
                  title: Text(service.name),
                  subtitle: Text(service.description), // الوصف
                  trailing: Icon(Icons.arrow_forward), // أيقونة للانتقال إلى صفحة الحجز
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceBookingScreen(service: service),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
