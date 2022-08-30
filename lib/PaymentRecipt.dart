import 'package:doc_home/Constants.dart';
import 'package:doc_home/DashBoard.dart';
import 'package:doc_home/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentRecipt extends StatefulWidget {
  const PaymentRecipt({Key? key}) : super(key: key);

  @override
  State<PaymentRecipt> createState() => _PaymentReciptState();
}

class _PaymentReciptState extends State<PaymentRecipt> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Image.asset('assets/images/payment_recipt.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment Recieved',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'We have recieved your ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                          TextSpan(
                            text: 'RS 500',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' against your appointment',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: blackColor,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PAYMENT DETAILS',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Amount',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColor,
                                  ),
                        ),
                        Text(
                          'RS 500',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment ID',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColor,
                                  ),
                        ),
                        Text(
                          '4567891',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Method',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColor,
                                  ),
                        ),
                        Text(
                          'Easypaisa Account 1111',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Time',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColor,
                                  ),
                        ),
                        Text(
                          '10:10 PM',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Date',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColor,
                                  ),
                        ),
                        Text(
                          '10, Nov 2021',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: blackColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Confirmation Email and SMS has been sent to your device',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .90,
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ), //For Image Asset
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: const Color(0xFF778899),
                      child: new Image.asset(
                        'assets/images/profile.png',
                      ), //For Image Asset
                    ),
                    Text(
                      'Dr. Maham Ahmad',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Gynecologist',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                    ),
                    Text(
                      'Peshawar, City',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                    ),
                    Text(
                      'Contact no: 03329898981',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: yellowColor,
                        ),
                        Icon(
                          Icons.star,
                          color: yellowColor,
                        ),
                        Icon(
                          Icons.star,
                          color: yellowColor,
                        ),
                        Icon(
                          Icons.star,
                          color: yellowColor,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: yellowColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/location_icon.png'),
                        const Text('Dr. Maham Ahmad is on her way!')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(const DashBoard());
                },
                child: const CustomButton(
                    buttonText: 'Done', buttonHeight: 30, buttonWidth: 100),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
