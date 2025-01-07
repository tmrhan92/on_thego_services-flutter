import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/api_service.dart';

class NearbyTherapistsScreen extends StatefulWidget {
  @override
  _NearbyTherapistsScreenState createState() => _NearbyTherapistsScreenState();
}

class _NearbyTherapistsScreenState extends State<NearbyTherapistsScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _therapists = [];
  bool _isLoading = false;

  Future<void> _fetchNearbyTherapists() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final therapists = await _apiService.getNearbyTherapists(position.latitude, position.longitude, 5000); // نصف قطر 5 كم
      setState(() {
        _therapists = therapists;
      });
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل في تحميل المعالجين القريبين')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNearbyTherapists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' القريبون')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _therapists.length,
        itemBuilder: (context, index) {
          final therapist = _therapists[index];
          return ListTile(
            title: Text(therapist['name']),
            subtitle: Text('الموقع: قريب منك'),
          );
        },
      ),
    );
  }
}
