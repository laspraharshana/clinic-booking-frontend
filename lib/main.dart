import 'package:flutter/material.dart';
import 'SigninAndSignup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 👇 Start app with SignIn & SignUp screen
      home: const SignInAndSignUp(),
    );
  }
}