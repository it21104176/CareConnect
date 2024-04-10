import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoseRequestPage extends StatefulWidget {
  @override
  _DoseRequestPageState createState() => _DoseRequestPageState();
}

class _DoseRequestPageState extends State<DoseRequestPage> {
  TextEditingController _medicineController = TextEditingController();
  TextEditingController _refillController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _medicineController.dispose();
    _refillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dose & Refill Request'),
        backgroundColor: Color(0xFF2E5969),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              color: Color(0xFFFFEADB),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add your prescribed Doses,',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Medicine name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _medicineController,
                        decoration: InputDecoration(
                          hintText: 'Enter your activity',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      color: Colors.white,
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _addMedicine,
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
                      'Low on stock?,',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Add Refill medicine here',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _refillController,
                        decoration: InputDecoration(
                          hintText: 'Enter your request',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 40),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _addRefillRequest,
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

  Future<void> _addMedicine() async {
    String newMedicine = _medicineController.text.trim();
    if (newMedicine.isNotEmpty) {
      try {
        await _firestore.collection('medicines').add({
          'medicine_name': newMedicine,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Medicine submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _medicineController.clear();
        });
      } catch (e) {
        print('Error adding medicine: $e');
        // Handle error
      }
    }
  }

  Future<void> _addRefillRequest() async {
    String newRefillRequest = _refillController.text.trim();
    if (newRefillRequest.isNotEmpty) {
      try {
        await _firestore.collection('refill_requests').add({
          'request': newRefillRequest,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Refill request submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _refillController.clear();
        });
      } catch (e) {
        print('Error adding refill request: $e');
        // Handle error
      }
    }
  }
}
