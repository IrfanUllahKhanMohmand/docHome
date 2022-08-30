import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_home/Constants.dart';
import 'package:doc_home/PaymentRecipt.dart';
import 'package:doc_home/Widgets/labTileActive.dart';
import 'package:doc_home/Widgets/testTile.dart';
import 'package:doc_home/Widgets/testTileActive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

import 'Widgets/alertDialogWidget.dart';
import 'Widgets/labTile.dart';

class LabTestSteps extends StatefulWidget {
  const LabTestSteps({Key? key}) : super(key: key);

  @override
  State<LabTestSteps> createState() => _LabTestStepsState();
}

class _LabTestStepsState extends State<LabTestSteps> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<FormState> _paymentForm = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _amountController =
      TextEditingController(text: '500');
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.

  int labIndex = -1;
  int testIndex = -1;
  int activeStep = 0; // Initial step set to 5.
  String currentLab = '';
  List currentList = [];

  String id = '0rTGAPcipY9VvYAKI9Kh';
  int upperBound = 3; // upperBound MUST BE total number of icons minus 1.
  late final Future? myFuture;
  int selectedLab = -1;
  String selectedLabName = '';
  String selectedLabId = '';
  int selectedTest = -1;
  String selectedTestName = '';
  bool formValidated = false;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('labs').snapshots();

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

    dateInput.text = "";

    labIndex = -1;
    super.initState();
  }

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
            "Laboratory",
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
      // Here we have initialized the stepper widget
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Get your lab services at your home in 4 easy steps.',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  NumberStepper(
                    numbers: const [
                      1,
                      2,
                      3,
                      4,
                    ],
                    stepColor: Colors.grey.shade200,
                    activeStepColor: secondaryColor,
                    numberStyle: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: whiteColor),

                    // activeStep property set to activeStep variable defined above.
                    activeStep: activeStep,

                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) {
                      setState(() {
                        activeStep = index;
                      });
                    },
                  ),
                  stepsWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: const Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Select Lab';
      case 1:
        return 'Select Test';

      case 2:
        return 'Give Details';

      case 3:
        return 'Payment';

      default:
        return 'Introduction';
    }
  }

  Widget stepsWidget() {
    switch (activeStep) {
      case 0:
        return Padding(
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
                                        'Select Laboratory',
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
                        FutureBuilder(
                            future: myFuture,
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: ((context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // id = snapshot.data[index];
                                                currentLab = snapshot
                                                    .data[index]['name'];
                                                currentList = snapshot
                                                    .data[index][currentLab];
                                                selectedLab = index;
                                                selectedLabName = currentLab;
                                                selectedLabId =
                                                    snapshot.data[index]['id'];
                                              });
                                            },
                                            child: index == selectedLab
                                                ? LabTileActive(
                                                    labTileActiveText: snapshot
                                                        .data[index]['name']
                                                        .toString())
                                                : LabTile(
                                                    labTileText: snapshot
                                                        .data[index]['name']
                                                        .toString()));
                                      }));
                                }
                              }

                              return Text("loading");
                            }),
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
                    if (activeStep < upperBound) {
                      setState(() {
                        activeStep++;
                      });
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
                            'Next',
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
        );
      case 1:
        return Padding(
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
                                        'Select Test',
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
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: currentList.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTest = index;
                                    selectedTestName =
                                        currentList[index].toString();
                                  });
                                },
                                child: selectedTest == index
                                    ? TestTileActive(
                                        testTileActiveText:
                                            currentList[index].toString())
                                    : TestTile(
                                        testTileText:
                                            currentList[index].toString()),
                              );
                            })),
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
                    if (activeStep < upperBound) {
                      setState(() {
                        activeStep++;
                      });
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
                            'Next',
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
        );

      case 2:
        return Padding(
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
                    child: Form(
                      key: _form,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 25),
                              child: TextFormField(
                                controller: _patientNameController,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Patient Name must not be empty!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Patient name:',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: primaryColor),
                                    hintText: 'Enter Patient Name'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Email must not be empty!';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                    return 'Enter Valid Email!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Email:',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: primaryColor),
                                    hintText: 'Enter Email'),
                              )),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 25),
                              child: TextFormField(
                                controller: dateInput,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Date must not be empty!';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                                decoration: InputDecoration(
                                    labelText: 'Date:',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: primaryColor),
                                    hintText: 'Enter Date'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                controller: _addressController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Address must not be empty!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                decoration: InputDecoration(
                                    labelText: 'Address:',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: primaryColor),
                                    hintText: 'Enter Address'),
                              )),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
                child: GestureDetector(
                  onTap: () {
                    if (_form.currentState!.validate()) {
                      formValidated = true;
                      if (activeStep < upperBound) {
                        setState(() {
                          activeStep++;
                        });
                      }
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
                            'Next',
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
        );

      case 3:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Form(
            key: _paymentForm,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(color: whiteColor),
                              child: Image.asset(
                                'assets/images/easypaisa.png',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(color: whiteColor),
                              child: Image.asset(
                                'assets/images/jazzcashlogo.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(color: whiteColor),
                              child: Image.asset(
                                'assets/images/visa_card.png',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              width: 110,
                              decoration: BoxDecoration(color: whiteColor),
                              child: Image.asset(
                                'assets/images/Cash.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Card Holder Name:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: TextFormField(
                        controller: _cardHolderNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Card Holder Name must not be empty!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Card Number:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: TextFormField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Card Number must not be empty!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Amount:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: TextFormField(
                        controller: _amountController,
                        enabled: false,
                        keyboardType: TextInputType.number,
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return 'Amount must not be empty!';
                        //   }
                        //   return null;
                        // },
                        decoration: const InputDecoration(
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 40),
                  child: GestureDetector(
                    onTap: () async {
                      if (_paymentForm.currentState!.validate() &&
                          formValidated &&
                          selectedLab != -1 &&
                          selectedTest != -1) {
                        try {
                          showDialog(
                              context: context,
                              builder: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                          await FirebaseFirestore.instance
                              .collection('labs')
                              .doc(selectedLabId)
                              .collection('transactions')
                              .doc()
                              .set({
                            'name': _patientNameController.text.trim(),
                            'email': _emailController.text.trim(),
                            'date': dateInput.text.trim(),
                            'address': _addressController.text.trim(),
                            'lab name': selectedLabName.trim(),
                            'test name': selectedTestName.trim(),
                            'cardholder name':
                                _cardHolderNameController.text.trim(),
                            'cardholder no': _cardNumberController.text.trim(),
                            'amount': _amountController.text.trim(),
                          }).then((value) => {Get.off(const PaymentRecipt())});
                        } on FirebaseException catch (e) {
                          Get.back();

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message.toString())));
                        }

                        // Get.to(const PaymentRecipt());
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialogWidget();
                            });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Fill all the forms')));
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
                              'Confirm Payment',
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
        );

      default:
        return const Text('Error');
    }
  }
}
