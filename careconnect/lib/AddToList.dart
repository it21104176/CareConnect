import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddToList extends StatefulWidget {
  @override
  _AddToListState createState() => _AddToListState();
}

class _AddToListState extends State<AddToList> {
  TextEditingController _activityController = TextEditingController();
  List<String> _activities = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Color(0xFF2E5969),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 3,
          color: Color(0xFFFFEADB), // Change card color
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'What do you want to do Today,',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 40,),
                const Text(
                  'Add Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _activityController,
                    decoration: InputDecoration(
                      hintText: 'Enter your activity',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15), // Increase TextFormField height
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black), // Adjust text size and color
                  ),
                  color: Colors.white, // Set container color to white
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _addActivity();
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
        ),
      ),
    );
  }

  Future<void> _addActivity() async {
    String newActivity = _activityController.text.trim();
    if (newActivity.isNotEmpty) {
      try {
        await _firestore.collection('activities').add({
          'activity': newActivity,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Activity submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _activities.add(newActivity);
          _activityController.clear();
        });
      } catch (e) {
        print('Error adding activity: $e');
        // Handle error
      }
    }
  }
}
