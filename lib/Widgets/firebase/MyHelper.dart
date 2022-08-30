import 'package:cloud_firestore/cloud_firestore.dart';

class MyHelper {
  static Future<List<String>> getLabs() async {
    var labData;
    // your implementation to make server calls
    final value = await FirebaseFirestore.instance.collection("labs").get();
    for (var element in value.docs) {
      labData.add(element['name']);
    }

    return labData;
  }
}
