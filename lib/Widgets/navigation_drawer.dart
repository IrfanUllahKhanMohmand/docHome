import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_home/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../authentication_service.dart';
import '../globals.dart' as globals;

final FirebaseAuth auth = FirebaseAuth.instance;
String _name = '';
String _num = '';
String _profileImage = '';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  void initState() {
    super.initState();
    _getNameAndNum();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: whiteColor,
      ),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: primaryTextColor,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    secondaryColor,
                    primaryColor,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: const Color(0xFF778899),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: CachedNetworkImage(
                            imageUrl: _profileImage,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ), //For Image Asset
                      ),
                      Text(
                        _name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: whiteColor),
                      ),
                      Text(
                        'Patient',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: whiteColor),
                      ),
                      Text(
                        _num,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(
                'Home',
              ),
              selected: globals.selectedDestination == 1,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.off(CarouselWithIndicatorDemo());

                // Get.off(MyHomePage(title: 'SELF DIAGNOSTIC'));
                selectDestination(1);
                // Get.to(MyHomePage(title: 'SELF DIAGNOSTIC'));
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: const Text('Edit Profile'),
              selected: globals.selectedDestination == 2,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer

                // Get.off(DoctorName());
                selectDestination(2);
                // Get.to(DoctorName());
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: const Text('My Doctors'),
              selected: globals.selectedDestination == 3,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(Medicine());

                // Get.off(Medicine());
                selectDestination(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: const Text('Messages'),
              selected: globals.selectedDestination == 4,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(Diseases());

                // Get.off(Diseases());
                selectDestination(4);
              },
            ),
            ListTile(
              leading: Icon(Icons.newspaper),
              title: const Text('Lab Reports'),
              selected: globals.selectedDestination == 5,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer

                // Get.off(Blogs());
                selectDestination(5);
                // Get.to(Blogs());
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: const Text('History'),
              selected: globals.selectedDestination == 6,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(AboutUs());

                // Get.off(AboutUs());
                selectDestination(6);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: const Text('About us'),
              selected: globals.selectedDestination == 7,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(ContactUs());

                // Get.off(ContactUs());
                selectDestination(7);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: const Text('Rate us'),
              selected: globals.selectedDestination == 8,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(ContactUs());

                // Get.off(ContactUs());
                selectDestination(8);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: const Text('Notifications'),
              selected: globals.selectedDestination == 9,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(ContactUs());

                // Get.off(ContactUs());
                selectDestination(9);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Signout'),
              selected: globals.selectedDestination == 10,
              selectedTileColor: primaryColor,
              selectedColor: whiteColor,
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Get.to(ContactUs());

                // Get.off(ContactUs());
                auth.signOut().then((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                }).catchError((e) => print(e));
              },
            ),
          ],
        ),
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      globals.selectedDestination = index;
    });
  }

  void _getNameAndNum() async {
    var usr = auth.currentUser;
    if (usr != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(usr.uid)
          .snapshots()
          .listen((userData) {
        if (userData.data()!.containsKey('name') &&
            userData.data()!.containsKey('contact no') &&
            userData.data()!.containsKey('profileImage')) {
          setState(() {
            _name = userData.data()!['name'].toString().trim();
            _num = userData.data()!['contact no'].toString().trim();
            _profileImage = userData.data()!['profileImage'].toString();
          });
        }
      });
    }
  }
}
