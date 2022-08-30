import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_home/Widgets/firebase/realtimeChangesRead.dart';
import 'package:flutter/material.dart';

class TestData extends StatelessWidget {
  TestData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getLabs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(labData.toString());
                }

                return Text("loading");
              })),
    );
  }
}

List<dynamic> labData = [];

Future<List<dynamic>> getLabs() async {
  final value = await FirebaseFirestore.instance.collection("labs").get();
  for (var element in value.docs) {
    labData.add("id : " + element.reference.id + element['name']);
  }

  return labData;
}

List<dynamic> alldata = [];

Future<List<dynamic>> getTests() async {
  final value = await FirebaseFirestore.instance
      .collection("labs")
      .doc('0rTGAPcipY9VvYAKI9Kh')
      .get();

  alldata = value.data()!["Tests"];

  return alldata;
}
