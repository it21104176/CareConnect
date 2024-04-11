import 'package:careconnect/ContactsPage.dart';
import 'package:careconnect/LocationPage.dart';
import 'package:careconnect/MediaPage.dart';
import 'package:careconnect/MedicationPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'map.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;

  // Define your pages here
  final List<Widget> _pages = [
    ContactsPage(),
    MedicationPage(),
    HomePage(),
    LocationPage(mapPage: MapPage()),
    MediaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xFF2E5969),
        color: Color(0xFF2E5969),
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.ac_unit, size: 26, color: Colors.white), // Contacts
          Icon(Icons.medication, size: 26, color: Colors.white), // Medication
          Icon(Icons.home, size: 26, color: Colors.white), // Replace with appropriate icon
          Icon(Icons.location_on, size: 26, color: Colors.white), // Location
          Icon(Icons.play_circle_outline, size: 26, color: Colors.white), // Media
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pages[_page],
    );
  }
}
