import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_erp/src/screens/home/home_screen.dart';
import 'package:school_erp/src/screens/login/login_or_register_page.dart';

class FirebaseAuthPage extends StatelessWidget {
  const FirebaseAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: ((context) {
              return CupertinoAlertDialog(
                title: const Text('Exit the App'),
                content: const Text('Are you sure you want to Exit!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('OK')),
                ],
              );
            }));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return const HomeScreen();
          }
          else{
            return const LoginOrRegisterPage();
          }
      })),
      ),
    );
  }
}