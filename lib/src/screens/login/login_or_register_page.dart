import 'package:flutter/material.dart';
import 'package:school_erp/src/screens/login/login_screen.dart';
import 'package:school_erp/src/screens/register/register_screen.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(
        onTap: togglePages,
      );
    }
    else{
      return RegisterScreen(
        onTap: togglePages,
      );
    }
  }
}