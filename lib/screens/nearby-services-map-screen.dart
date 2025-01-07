import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:services_app/services/api_service.dart';
import 'package:geolocator/geolocator.dart';

class NearbyServicesMapScreen extends StatefulWidget {
  final String serviceType;

  NearbyServicesMapScreen({required this.serviceType});

  @override
  _NearbyServicesMapScreenState createState() => _NearbyServicesMapScreenState();
}

class _NearbyServicesMapScreenState extends State<NearbyServicesMapScreen> {
  GoogleMapController? mapController;
  List<dynamic> _services = [];
  bool _isLoading = true;

  Future<void> _fetchNearbyServices() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final apiService = ApiService();
      // Fetch nearby services based on the service type
      List<dynamic> services = await apiService.getNearbyTherapists(position.latitude, position.longitude, 5000);
      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching nearby services: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNearbyServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby ${widget.serviceType} Services')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Center the map initially
          zoom: 10,
        ),
        markers: _services.map((service) {
          return Marker(
            markerId: MarkerId(service['id']),
            position: LatLng(service['latitude'], service['longitude']),
            infoWindow: InfoWindow(
              title: service['name'],
              snippet: service['description'],
            ),
          );
        }).toSet(),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
