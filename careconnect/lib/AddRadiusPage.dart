import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRadiusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Radius Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Get the current location
            Position? position = await _getCurrentLocation();

            if (position != null) {
              // Save the location to Firestore
              await _saveLocationToFirestore(position);

              // Navigate back
              Navigator.pop(context);
            } else {
              // Handle case where location is null (permission denied or other error)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('|Failed to retrieve location. Please check your settings and try again.'),
              ));
            }
          },
          child: Text('Get My Location'),
        ),
      ),
    );
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      // Check if the app already has location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission for location
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          // Handle denied permission
          return null;
        }
      }

      // Get the current position
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error retrieving location: $e');
      return null;
    }
  }

  Future<void> _saveLocationToFirestore(Position position) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add location data to Firestore
      await firestore.collection('locations').add({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print('Error saving location to Firestore: $e');
    }
  }
}
