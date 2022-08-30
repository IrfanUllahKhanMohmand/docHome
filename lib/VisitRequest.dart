import 'package:doc_home/Constants.dart';
import 'package:doc_home/Payments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VisitRequest extends StatefulWidget {
  final String name;
  const VisitRequest({Key? key, required this.name}) : super(key: key);

  @override
  State<VisitRequest> createState() => _VisitRequestState();
}

class _VisitRequestState extends State<VisitRequest> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
            "Visit Request",
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
                                  labelText: 'Patient Name:',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(),
                                  hintText: 'Enter Patient Name',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(),
                                ),
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
                                        .copyWith(),
                                    hintText: 'Enter Email',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith()),
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
                                        .copyWith(),
                                    hintText: 'Enter Date',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith()),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                controller: _addressController,
                                textCapitalization: TextCapitalization.words,
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
                                        .copyWith(),
                                    hintText: 'Enter Address',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith()),
                              )),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 25),
                              child: TextFormField(
                                controller: _reasonController,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                decoration: InputDecoration(
                                    labelText: 'Reason(optional):',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(),
                                    hintText: 'Enter Reason',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith()),
                              )),
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
                      Get.to(() => Payments(
                            serviceName: widget.name,
                            patientName: _patientNameController.text.trim(),
                            email: _emailController.text.trim(),
                            date: dateInput.text.trim(),
                            address: _addressController.text.trim(),
                          ));
                    } else {}
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
                            'Proceed to Pay',
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
