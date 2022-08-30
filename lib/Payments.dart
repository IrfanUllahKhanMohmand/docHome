import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_home/Constants.dart';
import 'package:doc_home/PaymentRecipt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payments extends StatefulWidget {
  final String serviceName;
  final String patientName;
  final String email;
  final String date;
  final String address;
  const Payments(
      {Key? key,
      required this.patientName,
      required this.email,
      required this.date,
      required this.address,
      required this.serviceName})
      : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _amoutController =
      TextEditingController(text: '500');
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paymentsPageBackground,
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
            "Payment",
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
                            decoration: const BoxDecoration(color: whiteColor),
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
                            decoration: const BoxDecoration(color: whiteColor),
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
                            decoration: const BoxDecoration(color: whiteColor),
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
                            decoration: const BoxDecoration(color: whiteColor),
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
              Form(
                key: _form,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                return 'Card Holder name must not be empty!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
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
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
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
                            controller: _amoutController,
                            enabled: false,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Amount must not be empty!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
                child: GestureDetector(
                  onTap: () async {
                    if (_form.currentState!.validate()) {
                      try {
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ));
                        await FirebaseFirestore.instance
                            .collection(widget.serviceName.trim())
                            .doc()
                            .set({
                          'patient name': widget.patientName.trim(),
                          'email': widget.email.trim(),
                          'date': widget.date.trim(),
                          'address': widget.address.trim(),
                          'cardholder name':
                              _cardHolderNameController.text.trim(),
                          'card number': _cardNumberController.text.trim(),
                          'amount': _amoutController.text.trim(),
                        }).then((value) => {Get.off(const PaymentRecipt())});
                      } on FirebaseException catch (e) {
                        Get.back();

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message.toString())));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Fill the form')));
                    }
                  },

                  // : showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         scrollable: true,
                  //         content: Column(
                  //           children: <Widget>[
                  //             Image.asset(
                  //                 'assets/images/close_cross.png'),
                  //             Text(
                  //               'Request Declined',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .headline5!
                  //                   .copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: primaryColor,
                  //                   ),
                  //             ),
                  //             Text(
                  //               'insufficient balance',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyLarge!
                  //                   .copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: primaryColor,
                  //                   ),
                  //             ),
                  //             Text(
                  //               'Please recharge your account!',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyLarge!
                  //                   .copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: primaryColor,
                  //                   ),
                  //             ),
                  //             const SizedBox(
                  //               height: 20,
                  //             ),
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.center,
                  //               children: [
                  //                 GestureDetector(
                  //                   onTap: () {
                  //                     check = true;
                  //                     Navigator.pop(context);
                  //                   },
                  //                   child: ClipRRect(
                  //                     borderRadius:
                  //                         BorderRadius.circular(6),
                  //                     child: Container(
                  //                       height: 40,
                  //                       width: 120,
                  //                       decoration: const BoxDecoration(
                  //                         color: primaryTextColor,
                  //                         gradient: LinearGradient(
                  //                           begin: Alignment.centerLeft,
                  //                           end: Alignment.centerRight,
                  //                           colors: [
                  //                             secondaryColor,
                  //                             primaryColor,
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Text(
                  //                             'Try Again',
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .bodyLarge!
                  //                                 .copyWith(
                  //                                     color: whiteColor),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     });

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
      ),
    );
  }
}
