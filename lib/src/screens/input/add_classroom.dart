import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../styles/app_color.dart';
import '../../styles/app_text_style.dart';

class AddClassRooms extends StatefulWidget {
  const AddClassRooms({super.key});

  @override
  State<AddClassRooms> createState() => _AddClassRoomsState();
}

class _AddClassRoomsState extends State<AddClassRooms> {

  //Form Key
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //Validator Method for TextField in thr Form
  String? checkTextFieldValidation(value){
    if(value == null || value.isEmpty){
      return "Required";
    }
    else{
      return null;
    }
  }

  //Check whether form is validated or not using Form key
  bool validateForm() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  //variables for TextFields in the Form
  final _classRoomsTextControler = TextEditingController();

  //Method to Clear the TextFields
  void clearTextFields() {
    _classRoomsTextControler.clear();
  }

  //Method to Create AlertDialogue Box
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //Container for title of the AlertDialogue Box
            title: Container(
              height: 40.0,
              decoration: const BoxDecoration(color: Colors.black),
              child: const Center(
                child: Text(
                  'Add ClassRoom',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            
            //Form for taking Inputs
            content: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _classRoomsTextControler,
                    style: AppTextStyle.style(
                      color: Colors.black.withOpacity(0.8),
                    ),
                    decoration: InputDecoration(
                      hintText: "ML 32, ML 33...",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      labelStyle: AppTextStyle.style(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    validator: checkTextFieldValidation,
                  ),
                ],
              ),
            ),
            
            //actoins for Dialogue Box
            actions: [
              //Button to Submit Form
              TextButton(
                  onPressed: () {
                    //Check weather the form is validated or not by calling Method
                    if(validateForm()){   
                      //Code to Store Data in Firebase Firestore
                    FirebaseFirestore.instance.collection('classrooms').add({
                      'faculty_no': _classRoomsTextControler.text,
                    }).then((value) {
                      //Show Toast after Data Entered in firebase
                      Fluttertoast.showToast(msg: "Data Entered Successfuly!");
                      //close dialogue box
                      Navigator.pop(context);
                      //clear Text Fields
                      clearTextFields();
                    }).onError((error, stackTrace) {
                      //show Dialogue if Error Occurs in Storing Data in Firebase
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
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    });
                    }
                  },
                  //child of Actions
                  child: const Text('Submit')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (() {
              createAlertDialog(context);
            }),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColor.primary, AppColor.primary.withOpacity(0.7)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'Add New ClassRoom',
                  style: AppTextStyle.style(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
