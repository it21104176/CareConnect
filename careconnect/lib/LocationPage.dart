import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import Google Maps Flutter package
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore package
import 'AddRadiusPage.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LatLng _location = LatLng(0, 0); // Default location

  @override
  void initState() {
    super.initState();
    _getLocationFromFirestore(); // Retrieve location from Firestore when the widget is initialized
  }

  Future<void> _getLocationFromFirestore() async {
    try {
      // Retrieve latitude and longitude from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('locations').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there's only one location in the collection)
        DocumentSnapshot<Map<String, dynamic>> firstDoc = querySnapshot.docs.first;

        // Extract latitude and longitude from the document
        double latitude = firstDoc['latitude'];
        double longitude = firstDoc['longitude'];

        setState(() {
          _location = LatLng(latitude, longitude); // Update the location state
        });
      }
    } catch (e) {
      print('Error fetching location from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
        backgroundColor: Color(0xFF2E5969),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: 20.0),
          SizedBox(
            height: 200.0,
            child: Card(
              color: Color(0xFFFFEADB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 8),
                        Text(
                          'Current Location',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        // Display map using GoogleMap widget
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _location,
                            zoom: 15.0,
                          ),
                          markers: Set<Marker>.of([
                            Marker(
                              markerId: MarkerId('currentLocation'),
                              position: _location,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          SizedBox(
            height: 200.0,
            child: Card(
              color: Color(0xFFFFEADB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location Focus',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddRadiusPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        // Display placeholder for location focus
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Location Focus Placeholder',
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
