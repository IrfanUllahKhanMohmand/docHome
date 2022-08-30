import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_home/Constants.dart';
import 'package:doc_home/OtpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';

import 'HomePage.dart';
import 'authentication_service.dart';
import 'main.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  MaskedTextController contactController =
      MaskedTextController(mask: '000-0000000');
  MaskedTextController cnicController =
      MaskedTextController(mask: '00000-0000000-0');

  final countryPicker =
      const FlCountryCodePicker(favorites: <String>['PK', 'AF']);
  String _countryDialCode = '+92';

  String _errorMessage = '';

  String profilePicLink = " ";
  String countryValue = " ";
  String stateValue = " ";
  String cityValue = " ";

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message!;
    });
  }

  int _value = -1;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool checkedValue = false;

  late FocusNode emailFocuNode;
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  @override
  void initState() {
    //set the initial value of text field
    super.initState();
    dateInput.text = "";
    emailFocuNode = FocusNode();
    _passwordVisible = false;
    _passwordConfirmVisible = false;
  }

  @override
  void dispose() {
    emailFocuNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold, color: primaryColor),
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                  key: _form,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            controller: nameController,
                            textCapitalization: TextCapitalization.words,
                            validator: (val) {
                              if (val!.isEmpty)
                                return 'Name must not be empty!';
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                fillColor: primaryColor,
                                labelText: 'Full Name',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),
                                hintText: 'Enter Full Name'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: emailFocuNode,
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
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                ),
                                fillColor: primaryColor,
                                labelText: 'Email',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),
                                hintText: 'Enter Email'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: contactController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Contact No must not be empty!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                ),
                                prefix: GestureDetector(
                                  onTap: () async {
                                    final code = await countryPicker.showPicker(
                                        context: context);
                                    if (code != null) {
                                      setState(() {
                                        _countryDialCode = code.dialCode;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: primaryColor,
                                      ),
                                      child: Text(
                                        _countryDialCode,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                                fillColor: primaryColor,
                                labelText: 'Contact No',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),
                                hintText: '3XX-XXXXXXX'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: cnicController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'CNIC must not be empty!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                fillColor: primaryColor,
                                labelText: 'CNIC No',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),
                                hintText: 'xxxx-xxxxxx-x'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            controller: passwordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Password must not be empty!';
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(val)) {
                                return 'Should contain upper, lowercase, digit and symbol';
                              }
                              return null;
                            },
                            obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              fillColor: primaryColor,
                              labelText: 'Password',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor),
                              hintText: 'Enter Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            controller: confirmpPasswordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Confirm Password must not be empty!';
                              }
                              if (val != passwordController.text) {
                                return 'Confirm Password must match!';
                              }
                              return null;
                            },
                            obscureText: !_passwordConfirmVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: primaryColor),
                              ),
                              fillColor: primaryColor,
                              labelText: 'Confirm Password',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor),
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordConfirmVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordConfirmVisible =
                                        !_passwordConfirmVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TextFormField(
                                  controller: dateInput,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        dateInput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'DOB must not be empty!';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                      ),
                                      fillColor: primaryColor,
                                      labelText: 'DOB',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: primaryColor),
                                      hintText: '--/--/--'),
                                  readOnly: true,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);
                                    //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      children: [
                                        Text(
                                          'Select',
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Gender',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as int;
                                        });
                                      }),
                                  Text(
                                    'Male',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: primaryColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 2,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value as int;
                                        });
                                      }),
                                  Text(
                                    'Female',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: primaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              ///Adding CSC Picker Widget in app
                              CSCPicker(
                                key: _cscPickerKey,
                                layout: Layout.vertical,

                                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                                showStates: true,

                                /// Enable disable city drop down [OPTIONAL PARAMETER]
                                showCities: true,

                                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                                // flagState: CountryFlag.DISABLE,

                                // /Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                dropdownDecoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: primaryColor))),

                                ///placeholders for dropdown search field
                                countrySearchPlaceholder: "Country",
                                stateSearchPlaceholder: "State",
                                citySearchPlaceholder: "City",

                                ///labels for dropdown
                                countryDropdownLabel: "*Country",
                                stateDropdownLabel: "*State",
                                cityDropdownLabel: "*City",

                                ///Default Country
                                //defaultCountry: DefaultCountry.India,

                                ///Disable country dropdown (Note: use it with default country)
                                //disableCountry: true,

                                ///selected item style [OPTIONAL PARAMETER]
                                selectedItemStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: primaryColor),

                                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                dropdownHeadingStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: primaryColor),

                                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                dropdownItemStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: primaryColor),

                                ///Dialog box radius [OPTIONAL PARAMETER]
                                dropdownDialogRadius: 10.0,

                                ///Search bar radius [OPTIONAL PARAMETER]
                                searchBarRadius: 10.0,

                                ///triggers once country selected in dropdown
                                onCountryChanged: (value) {
                                  setState(() {
                                    ///store value in country variable
                                    countryValue = value;
                                  });
                                },

                                ///triggers once state selected in dropdown
                                onStateChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      stateValue = value; // Safe
                                    }
                                  });
                                },

                                ///triggers once city selected in dropdown
                                onCityChanged: (value) {
                                  setState(() {
                                    ///store value in city variable
                                    if (value != null) {
                                      cityValue = value; // Safe
                                    }
                                  });
                                },
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: TextFormField(
                            controller: adressController,
                            textCapitalization: TextCapitalization.words,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Adress must not be empty!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                fillColor: primaryColor,
                                labelText: 'Address',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),
                                hintText: 'Enter Your Address'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
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
                                      children: [
                                        Text(
                                          'Upload Picture',
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: 120,
                                width: 100,
                                child: Stack(children: <Widget>[
                                  CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: _imageFile == null
                                        ? const AssetImage(
                                            "assets/images/profile.png")
                                        : FileImage(File(_imageFile!.path))
                                            as ImageProvider,
                                    // : NetworkImage(profilePicLink)
                                    //     as ImageProvider,
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: 20,
                              child: CheckboxListTile(
                                value: checkedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    if (_form.currentState!.validate() &&
                                        _value != -1 &&
                                        countryValue != " " &&
                                        stateValue != " " &&
                                        cityValue != " ") {
                                      checkedValue = newValue!;
                                    } else {
                                      checkedValue = false;
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .80,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I agree to the Doc home\'s',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(),
                                  ),
                                  TextSpan(
                                    text: ' Terms of use',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                  ),
                                  TextSpan(
                                    text: ' and',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(),
                                  ),
                                  TextSpan(
                                    text: ' Informed consent',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                  ),
                                  TextSpan(
                                    text: ' and',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(),
                                  ),
                                  TextSpan(
                                    text: ' Privacy policy',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (_value == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please Select Gender')));
                              }
                              if (countryValue == " ") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please Choose Country')));
                              }
                              if (countryValue != " " && stateValue == " ") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please Choose State')));
                              }
                              if (stateValue != " " && cityValue == " ") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please Choose City')));
                              }
                              if (_imageFile == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please pick the profile picture')));
                              }

                              if (_form.currentState!.validate() &&
                                  _value != -1 &&
                                  checkedValue &&
                                  countryValue != " " &&
                                  stateValue != " " &&
                                  cityValue != " " &&
                                  _imageFile != null) {
                                try {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                  // showLoaderDialog(context);
                                  final _credential = await auth
                                      .createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  )
                                      .then((onValue) async {
                                    FirebaseStorage storage =
                                        FirebaseStorage.instance;

                                    //Create a reference to the location you want to upload to in firebase
                                    Reference reference = storage.ref().child(
                                        "profileImages/${onValue.user!.uid}");

                                    //Upload the file to firebase
                                    UploadTask uploadTask = reference
                                        .putFile(File(_imageFile!.path));

                                    TaskSnapshot taskSnapshot =
                                        await uploadTask;

                                    // // Waits till the file is uploaded then stores the download url
                                    String url =
                                        await taskSnapshot.ref.getDownloadURL();

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(onValue.user!.uid)
                                        .set({
                                      'name': nameController.text.trim(),
                                      'email': emailController.text.trim(),
                                      'contact no':
                                          contactController.text.trim(),
                                      'cnic no': cnicController.text.trim(),
                                      'country': countryValue.trim(),
                                      'city': cityValue.trim(),
                                      'state': stateValue.trim(),
                                      'address': adressController.text.trim(),
                                      'dob': dateInput.text.trim(),
                                      'gender': _value == 1 ? 'Male' : 'Female',
                                      'profileImage': url
                                    }).then((value) =>
                                            {Get.offAll(const MyHomePage())});
                                  });
                                } on FirebaseAuthException catch (e) {
                                  Get.back();
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'The password provided is too weak.')));
                                  } else if (e.code == 'email-already-in-use') {
                                    emailFocuNode.requestFocus();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'The account already exists for that email.')));
                                  }
                                }
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker
        .pickImage(source: source, maxHeight: 200, maxWidth: 200)
        .whenComplete(() => Get.back());
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}

Future<User> handleSignUp(email, password) async {
  UserCredential result = await auth.createUserWithEmailAndPassword(
      email: email, password: password);
  final User user = result.user!;

  return user;
}
