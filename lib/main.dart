import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doc_home/AnimatedPositonedWidget.dart';
import 'package:doc_home/DashBoard.dart';
import 'package:doc_home/Details.dart';
import 'package:doc_home/LabTestsSteps.dart';
import 'package:doc_home/OnBoardingScreen.dart';
import 'package:doc_home/PaymentRecipt.dart';
import 'package:doc_home/Payments.dart';
import 'package:doc_home/SignUp.dart';
import 'package:doc_home/SplashScreenWidget.dart';
import 'package:doc_home/VisitRequest.dart';
import 'package:doc_home/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'Widgets/firebase/oneTimeRead.dart';
import 'Widgets/firebase/realtimeChangesRead.dart';
import 'Widgets/firebase/testsData.dart';

Future main() async {
  await Hive.initFlutter();
  await Hive.openBox('');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Doc Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(),
        home: const SplashScreenWidget(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return const DashBoard();
    }
    return const MyHomePage();
    // if (firebaseUser != null) {
    //   return OneTimerRead();
    // }
    // return OneTimerRead();
  }
}
