import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTreatmentPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Treatment Plan'),
        backgroundColor: Color(0xFF2E5969),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTreatmentBox(context, 'Morning,'),
            SizedBox(height: 20),
            _buildTreatmentBox(context, 'Mid-Day,'),
            SizedBox(height: 20),
            _buildTreatmentBox(context, 'Night,'),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentBox(BuildContext context, String time) {
    TextEditingController _medicineNameController = TextEditingController();
    TextEditingController _dosageController = TextEditingController();

    return Card(
      elevation: 3,
      color: Color(0xFFFFEADB),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _medicineNameController,
              decoration: InputDecoration(
                labelText: 'Medicine Name',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _dosageController,
              decoration: InputDecoration(
                labelText: 'Dosage',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _submitTreatmentPlan(context, time, _medicineNameController.text, _dosageController.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF379199)),
              ),
              child: Text('Submit',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTreatmentPlan(BuildContext context, String time, String medicineName, String dosage) async {
    try {
      await _firestore.collection('treatment_plans').add({
        'time': time,
        'medicine_name': medicineName,
        'dosage': dosage,
      });
      // Data submitted successfully
      print('Treatment plan submitted successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Treatment plan submitted successfully'),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      // Error occurred while submitting data
      print('Error submitting treatment plan: $e');
      // Handle error appropriately
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting treatment plan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
