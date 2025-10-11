import 'package:clinic_booking_frontend/dasboard.dart';
import 'package:clinic_booking_frontend/report.dart';
import 'package:clinic_booking_frontend/signin_signup.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'Signinandsignup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Booking',
      theme: ThemeData(primarySwatch: Colors.blue),
      // 👇 Start app with SignIn & SignUp screen
      home: const ReportsAnalyticsPage(),
    );
  }
}
