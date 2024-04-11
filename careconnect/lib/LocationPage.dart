import 'package:flutter/material.dart';
import 'map.dart'; // Import your MapPage widget

class LocationPage extends StatelessWidget {
  final MapPage mapPage; // Accept MapPage widget as a parameter

  const LocationPage({Key? key, required this.mapPage}) : super(key: key);

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
            height: 400.0,
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
                    child: mapPage, // Display the MapPage widget here
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
                            // Handle onPressed
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
