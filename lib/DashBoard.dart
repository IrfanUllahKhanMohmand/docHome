import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_home/Details.dart';
import 'package:doc_home/PageViews.dart';
import 'package:doc_home/VisitRequest.dart';
import 'package:doc_home/Widgets/customButton.dart';
import 'package:doc_home/Widgets/customTopBar.dart';
import 'package:doc_home/Widgets/detailsTile.dart';
import 'package:doc_home/Widgets/detailsTileSelected.dart';
import 'package:doc_home/Widgets/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Constants.dart';
import 'LabTestsSteps.dart';

int selectedIndex = -1;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _name = '';
  String _profileImage = '';

  @override
  void initState() {
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/appBarImage.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Text("Hello, $_name"),
            elevation: 0,
            actions: [
              IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Air it',
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: CachedNetworkImage(
                    imageUrl: _profileImage,
                    height: 50.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 260,
                  width: double.infinity,
                  child: const PageViews()),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          'What do you need ?',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          child: Container(
                            height: 100,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: categoryColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/doctor.png',
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'General',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                ),
                                Text(
                                  'Physician',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          child: Container(
                            height: 100,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: categoryColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Gyne.png',
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Gynecologist',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                ),
                                Text(
                                  '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const LabTestSteps());
                          },
                          child: InkWell(
                            child: Container(
                              height: 100,
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: categoryColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/flask.png',
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Lab Test',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                  ),
                                  Text(
                                    '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * .90,
                                  decoration: const BoxDecoration(
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Other Services',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Bandage.png',
                                  ),
                                  Text(
                                    'Bandage',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Plaster.png',
                                  ),
                                  Text(
                                    'Plaster',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/drip.png',
                                  ),
                                  Text(
                                    'Drip',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/injection.png',
                                  ),
                                  Text(
                                    'Injection',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/physio.png',
                                  ),
                                  Text(
                                    'Physiotherapy',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/injection2.png',
                                  ),
                                  Text(
                                    'Injection',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(const Details());
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //           scrollable: true,
                                  //           content: SingleChildScrollView(
                                  //             child: Column(
                                  //               children: [
                                  //                 Column(
                                  //                   children: [
                                  //                     GestureDetector(
                                  //                       onTap: () {},
                                  //                       child:
                                  //                           const CustomTopBar(
                                  //                         barText: 'Details',
                                  //                         barHeight: 40,
                                  //                         barWidth: 500,
                                  //                         barRadius: 2,
                                  //                       ),
                                  //                     ),
                                  //                     const SizedBox(
                                  //                       height: 15,
                                  //                     ),
                                  //                     const DetailsTile(
                                  //                         imagePath:
                                  //                             'assets/images/injection2.png',
                                  //                         tileText: 'Injection',
                                  //                         tileDescription:
                                  //                             'Description',
                                  //                         tileFee: 'Fee 500'),
                                  //                     const SizedBox(
                                  //                       height: 20,
                                  //                     ),
                                  //                     const DetailsTile(
                                  //                         imagePath:
                                  //                             'assets/images/Plaster.png',
                                  //                         tileText: 'Plaster',
                                  //                         tileDescription:
                                  //                             'Description',
                                  //                         tileFee: 'Fee 500'),
                                  //                     const SizedBox(
                                  //                       height: 20,
                                  //                     ),
                                  //                     const DetailsTile(
                                  //                         imagePath:
                                  //                             'assets/images/drip.png',
                                  //                         tileText: 'Drip',
                                  //                         tileDescription:
                                  //                             'Description',
                                  //                         tileFee: 'Fee 500'),
                                  //                     const SizedBox(
                                  //                       height: 20,
                                  //                     ),
                                  //                     const DetailsTile(
                                  //                         imagePath:
                                  //                             'assets/images/Bandage.png',
                                  //                         tileText: 'Bandage',
                                  //                         tileDescription:
                                  //                             'Description',
                                  //                         tileFee: 'Fee 500'),
                                  //                     const SizedBox(
                                  //                       height: 20,
                                  //                     ),
                                  //                     const DetailsTile(
                                  //                         imagePath:
                                  //                             'assets/images/physio.png',
                                  //                         tileText: 'Physio',
                                  //                         tileDescription:
                                  //                             'Description',
                                  //                         tileFee: 'Fee 500'),
                                  //                     const SizedBox(
                                  //                       height: 20,
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //                 const SizedBox(
                                  //                   height: 20,
                                  //                 ),
                                  //                 GestureDetector(
                                  //                   onTap: () {
                                  //                     Get.to(
                                  //                         const VisitRequest());
                                  //                   },
                                  //                   child: const CustomTopBar(
                                  //                     barText: 'Continue',
                                  //                     barHeight: 40,
                                  //                     barWidth: 100,
                                  //                     barRadius: 10,
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ));
                                  //     });
                                },
                                child: Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * .50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        'more details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }

  void _getName() async {
    var usr = _firebaseAuth.currentUser;
    if (usr != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(usr.uid)
          .snapshots()
          .listen((userData) {
        if (userData.data()!.containsKey('name') &&
            userData.data()!.containsKey('profileImage')) {
          setState(() {
            var split = userData.data()!['name'].toString().split(" ");
            _name = split[0];
            _profileImage = userData.data()!['profileImage'].toString();
          });
        }
      });
    }
  }
}
