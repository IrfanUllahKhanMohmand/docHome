import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../labTile.dart';

class OneTimerRead extends StatefulWidget {
  @override
  State<OneTimerRead> createState() => _OneTimerReadState();
}

class _OneTimerReadState extends State<OneTimerRead> {
  late final Future? myFuture;

  Future getLabs() async {
    var labItems = <Map>[];

    final value = await FirebaseFirestore.instance.collection("labs").get();
    for (var element in value.docs) {
      var map = {};
      map['name'] = element['name'].toString();
      map[element['name'].toString()] = element.data()['Tests'];
      map['id'] = element.reference.id.toString();

      labItems.add(map);
    }

    // labItems.forEach(
    //   (element) {
    //     var test = element['tests'];
    //     test.forEach((test) {
    //       labData.add(test);
    //     });
    //   },
    // );
    print(labItems);
    return labItems;
  }

  @override
  void initState() {
    myFuture = getLabs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              // var _list = [];
              // for (var message in snapshot.data!.docs.toList()) {
              //   _list.add(message.data().toString());
              //   _list.add(message.id);
              // }
              // return Text(_list.toString());

              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Text(snapshot.data[index]['name'].toString()),
                          Text(snapshot.data[index]
                                  [snapshot.data[index]['name'].toString()]
                              .toString()),
                        ],
                      );
                    }));
              }
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
