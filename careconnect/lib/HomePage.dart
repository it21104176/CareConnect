import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:careconnect/AddToList.dart';
import 'package:careconnect/AddTreatmentPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xFF2E5969),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: 20.0),
          SizedBox(
            height: 350.0,
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
                          'Treatment Plans',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddTreatmentPage()),
                            );
                          },
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('treatment_plans').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      Map<String, List<DocumentSnapshot>> groupedPlans = {};
                      snapshot.data!.docs.forEach((plan) {
                        final time = plan['time'];
                        if (groupedPlans.containsKey(time)) {
                          groupedPlans[time]!.add(plan);
                        } else {
                          groupedPlans[time] = [plan];
                        }
                      });

                      return Expanded(
                        child: ListView(
                          children: groupedPlans.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: entry.value.map((plan) {
                                    return Card(
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: Icon(Icons.medical_services_rounded, size: 36),
                                        title: Text(plan['medicine_name'],
                                            style: TextStyle(fontSize: 18.0)
                                        ),
                                        subtitle: Text('${plan['dosage']}',
                                            style: TextStyle(fontSize: 14.0)
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          SizedBox(
            height: 235.0,
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
                          'To-Do List',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddToList()),
                            );
                          },
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('activities').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return Expanded(
                        child: ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              color: Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.done_all_rounded, size: 36),
                                title: Text(doc['activity'],
                                  style: TextStyle(fontSize: 18.0)
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
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
