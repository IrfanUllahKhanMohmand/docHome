import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RealTimeChangesRead extends StatefulWidget {
  @override
  _RealTimeChangesReadState createState() => _RealTimeChangesReadState();
}

class _RealTimeChangesReadState extends State<RealTimeChangesRead> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('labs').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['name']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
