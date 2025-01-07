import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق من تمكين خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // إذا كانت الخدمة غير مفعلة
      return null;
    }

    // تحقق من حالة الإذن
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // إذا رفض المستخدم الإذن
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // إذا كان الإذن مرفوضًا دائمًا
      return null;
    }

    // الحصول على الموقع الحالي
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
