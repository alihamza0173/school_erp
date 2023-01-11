import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../styles/app_color.dart';
import '../../styles/app_text_style.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

 bool validateForm() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool _isSecure = true;
  final _emailTextControler = TextEditingController();
  final _passwordTextControler = TextEditingController();

  dynamic myProgressBar() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((progressBarBontext) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }));
  }

  @override
  void dispose() {
    _emailTextControler.dispose();
    _passwordTextControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.primaryLight, AppColor.primary]),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset("assets/images/splash.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Hi Student",
                        style: AppTextStyle.style(
                            fontSize: 34, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Sign in to Continue",
                        style: AppTextStyle.style(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.4),
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(38),
                    topLeft: Radius.circular(38),
                  ),
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailTextControler,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration: InputDecoration(
                          hintText: 'HSA@gmail.com',
                          labelText: 'Mobile Number/Email',
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          labelStyle: AppTextStyle.style(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Required";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _isSecure,
                        controller: _passwordTextControler,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSecure = !_isSecure;
                                });
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: _isSecure
                                    ? Colors.black.withOpacity(0.8)
                                    : Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                          labelText: 'Password',
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          labelStyle: AppTextStyle.style(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Required";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () async{
                          if(validateForm()){
                            myProgressBar();
                            await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextControler.text,
                                  password: _passwordTextControler.text)
                              .then((value) {
                                FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set({
                                  "Email": value.user!.email,
                                  "Id": value.user!.uid,
                                  });
                                Navigator.of(context).pop();
                            Fluttertoast.showToast(
                                msg: "Account Created Scuccessfuly!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }).onError((error, stackTrace) {
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (c) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: Text(error.toString()),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                            print("Error: ${error.toString()}");
                          });
                          }
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColor.primary,
                                AppColor.primary.withOpacity(0.7)
                              ],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(5, 5),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 32),
                                    child: Text(
                                      'SIGN UP',
                                      style: AppTextStyle.style(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.white, size: 32),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Login',
                              style: AppTextStyle.style(
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
