import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDetPage extends StatefulWidget {
  @override
  _DoctorDetPageState createState() => _DoctorDetPageState();
}

class _DoctorDetPageState extends State<DoctorDetPage> {
  TextEditingController _professionalController = TextEditingController();
  TextEditingController _professionalnumController = TextEditingController();

  TextEditingController _emergencyController = TextEditingController();
  TextEditingController _emergencynumController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _professionalController.dispose();
    _professionalnumController.dispose();
    _emergencyController.dispose();
    _emergencynumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
        backgroundColor: Color(0xFF2E5969),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Card(
              elevation: 3,
              color: Color(0xFFFFEADB),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add Medical Professional',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Doctor Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _professionalController,
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Doctor s Number',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _professionalnumController,
                        decoration: InputDecoration(
                          hintText: 'Enter Number',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _addProfessional,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF379199)),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Card(
              elevation: 3,
              color: Color(0xFFFFEADB),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add Emergency Contacts',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Emegency Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _emergencyController,
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Emegency Number',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _emergencynumController,
                        decoration: InputDecoration(
                          hintText: 'Enter number',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _addEmergencyContact,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF379199)),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addProfessional() async {
    String newProfessional = _professionalController.text.trim();
    String newProfessionalnum = _professionalnumController.text.trim();
    if (newProfessional.isNotEmpty && newProfessionalnum.isNotEmpty) {
      try {
        await _firestore.collection('doctor_contacts').add({
          'Dname': newProfessional,
          'Dnumber': newProfessionalnum
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Professional added successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _professionalController.clear();
        });
      } catch (e) {
        print('Error adding professional: $e');
        // Handle error
      }
    }
  }

  Future<void> _addEmergencyContact() async {
    String newEmergencyContact = _emergencyController.text.trim();
    String newEmergencynumContact = _emergencynumController.text.trim();
    if (newEmergencyContact.isNotEmpty && newEmergencynumContact.isNotEmpty) {
      try {
        await _firestore.collection('emergency_contacts').add({
          'Ename': newEmergencyContact,
          'Enumber': newEmergencynumContact
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Emergency contact added successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _emergencyController.clear();
        });
      } catch (e) {
        print('Error adding emergency contact: $e');
        // Handle error
      }
    }
  }
}
