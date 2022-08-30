import 'package:doc_home/Constants.dart';
import 'package:doc_home/VisitRequest.dart';
import 'package:doc_home/Widgets/detailsTileSelected.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/detailsTile.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedIndex = -1;
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/appBarImage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "Details",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, color: whiteColor),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset(
                  'assets/images/profile.png',
                  height: 50.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        selectedIndex == 0
                            ? const DetailsTileSelected(
                                imagePath: 'assets/images/injection2.png',
                                tileText: 'Injection',
                                tileDescription: 'Description',
                                tileFee: 'Fee 500')
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                child: const AbsorbPointer(
                                  child: DetailsTile(
                                      imagePath: 'assets/images/injection2.png',
                                      tileText: 'Injection',
                                      tileDescription: 'Description',
                                      tileFee: 'Fee 500'),
                                ),
                              ),
                        selectedIndex == 1
                            ? const DetailsTileSelected(
                                imagePath: 'assets/images/Plaster.png',
                                tileText: 'Plaster',
                                tileDescription: 'Description',
                                tileFee: 'Fee 500')
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name = 'Plaster';
                                    selectedIndex = 1;
                                  });
                                },
                                child: const AbsorbPointer(
                                  child: DetailsTile(
                                      imagePath: 'assets/images/Plaster.png',
                                      tileText: 'Plaster',
                                      tileDescription: 'Description',
                                      tileFee: 'Fee 500'),
                                ),
                              ),
                        selectedIndex == 2
                            ? const DetailsTileSelected(
                                imagePath: 'assets/images/drip.png',
                                tileText: 'Drip',
                                tileDescription: 'Description',
                                tileFee: 'Fee 500')
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name = 'Drip';
                                    selectedIndex = 2;
                                  });
                                },
                                child: const AbsorbPointer(
                                  child: DetailsTile(
                                      imagePath: 'assets/images/drip.png',
                                      tileText: 'Drip',
                                      tileDescription: 'Description',
                                      tileFee: 'Fee 500'),
                                ),
                              ),
                        selectedIndex == 3
                            ? const DetailsTileSelected(
                                imagePath: 'assets/images/Bandage.png',
                                tileText: 'Bandage',
                                tileDescription: 'Description',
                                tileFee: 'Fee 500')
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name = 'Bandage';
                                    selectedIndex = 3;
                                  });
                                },
                                child: const AbsorbPointer(
                                  child: DetailsTile(
                                      imagePath: 'assets/images/Bandage.png',
                                      tileText: 'Bandage',
                                      tileDescription: 'Description',
                                      tileFee: 'Fee 500'),
                                ),
                              ),
                        selectedIndex == 4
                            ? const DetailsTileSelected(
                                imagePath: 'assets/images/physio.png',
                                tileText: 'Physiotherapy',
                                tileDescription: 'Description',
                                tileFee: 'Fee 500')
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    name = 'Physiotherapy';
                                    selectedIndex = 4;
                                  });
                                },
                                child: const AbsorbPointer(
                                  child: DetailsTile(
                                      imagePath: 'assets/images/physio.png',
                                      tileText: 'Physiotherapy',
                                      tileDescription: 'Description',
                                      tileFee: 'Fee 500'),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
                child: GestureDetector(
                  onTap: () {
                    if (name != '') {
                      Get.to(() => VisitRequest(
                            name: name,
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Choose one of the Services')));
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 40,
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
                            'Continue',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
