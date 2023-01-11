import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/firebase_auth.dart';
import '../../styles/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (c) {
              return const FirebaseAuthPage();
            }), ((route) => false)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.primaryLight, AppColor.primary]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'School',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'ERP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 70.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              const Image(image: AssetImage('assets/images/splash.png')),
            ],
          ),
        ),
      ),
    );
  }
}
