import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_erp/formhelper.dart';
import 'package:school_erp/model/teachers.dart';
import '../../styles/app_text_style.dart';

class AddTeachers extends StatefulWidget {
  const AddTeachers({super.key});

  @override
  State<AddTeachers> createState() => _AddTeachersState();
}

class _AddTeachersState extends State<AddTeachers> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? validateFormField(value) {
    if (value == null || value.isEmpty) {
      return "Required";
    } else {
      return null;
    }
  }

  bool formValidate() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

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

  dynamic dialogueBoxAgterFirebaseError(error) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  String? selectedDesignation;
  String? teacherName;
  String? teacherFacultyName;
  String? teacherAlias;
  String? teacherEmail;
  int? teacherNumber;

  int? sortColumnIndex;
  bool sortAscending = false;

  List<String> teacherDesignation = [
    'Professor',
    'Assistant Professor',
    'Associate Professor',
    'Guest Faculty'
  ];

  List<DataColumn> buildColumn(List<String> column) {
    return column
        .map((e) => DataColumn(
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sortAscending = ascending;
              });
            },
            label: Text(e)))
        .toList();
  }

  List<DataRow> buildRow(List<Teacher>? teachers) {
    return teachers!
        .map((e) => DataRow(cells: [
              DataCell(Text(e.name)),
              DataCell(Text(e.facultyNo)),
              DataCell(Text(e.alias)),
              DataCell(Text(e.designation)),
              DataCell(Text(e.emailId)),
              DataCell(Text('${e.contactNumber}')),
              DataCell(
                Icon(
                  Icons.edit,
                  color: Colors.green[800],
                ),
                onTap: () {
                  teacherName = e.name;
                  teacherAlias = e.alias;
                  selectedDesignation = e.designation;
                  teacherNumber = e.contactNumber;
                  teacherFacultyName = e.facultyNo;
                  teacherEmail = e.emailId;
                  createAlertDialog(context, isEditMode: true, teacher: e);
                },
              ),
              DataCell(
                Icon(
                  CupertinoIcons.delete,
                  color: Colors.red[500],
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (c) {
                        return CupertinoAlertDialog(
                          title: const Text("Are you Sure!"),
                          content: const Text('You Want to Delete this Data'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                myProgressBar();
                                deleteTeacerData(e.id);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                },
              ),
            ]))
        .toList();
  }

  //Method for entering data in teacher's collection on firebase
  Future enterTeacherData(Teacher teacher) async {
    DocumentReference teachersref =
        FirebaseFirestore.instance.collection('teachers').doc();
    teacher.id = teachersref.id;
    final json = teacher.toJson();
    await teachersref.set(json).then((value) {
      Fluttertoast.showToast(msg: "Data Entered Successfuly!");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      dialogueBoxAgterFirebaseError(error);
    });
  } //end method

  Future updateTeacerData(Teacher teacher) async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacher.id)
        .update({
      'name': teacher.name,
      'faculty_no': teacher.facultyNo,
      'alias': teacher.alias,
      'designation': teacher.designation,
      'email_id': teacher.emailId,
      'contact_number': teacher.contactNumber,
    }).then((value) {
      Fluttertoast.showToast(msg: "Data Edited Successfuly!");
      Navigator.pop(context);
      Navigator.of(context).pop();
    }).onError(
      (error, stackTrace) => dialogueBoxAgterFirebaseError(error),
    );
  }

  Future deleteTeacerData(String id) async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(id)
        .delete()
        .then((value) {
      {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Data Deleted Successfuly!");
      }
    }).onError(
      (error, stackTrace) => dialogueBoxAgterFirebaseError(error),
    );
  }

  // list for teacher's id collections
  // List<String> teacherIds = [];

  // method to geta data from teacher's collection from firebse
  // Future getTeachersData() async{
  //   await  teachers.get().then((snapshot) =>
  //   snapshot.docs.forEach((element) {
  //     teacherIds.add(element.reference.id);
  //   })
  //   );
  // } //method end

  //alert Dialogue box to take inputs for teacher data
  createAlertDialog(BuildContext context,
      {bool isEditMode = false, Teacher? teacher}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
                height: 40.0,
                decoration: const BoxDecoration(color: Colors.black),
                child: Center(
                    child: Text(
                  isEditMode ? 'Edit Teacher' : 'Add Teacher',
                  style: const TextStyle(color: Colors.white),
                ))),
            content: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Teacher's Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: isEditMode ? teacherName : '',
                        onChanged: (value) {
                          teacherName = value;
                        },
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration:
                            FormHelper.formFieldDecoration("Teacher's Name..."),
                        validator: validateFormField),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Faculty No",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: isEditMode ? teacherFacultyName : '',
                        onChanged: (value) {
                          teacherFacultyName = value;
                        },
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration:
                            FormHelper.formFieldDecoration("Faculty No..."),
                        validator: validateFormField),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Alias",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: isEditMode ? teacherAlias : '',
                        onChanged: (value) {
                          teacherAlias = value;
                        },
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration: FormHelper.formFieldDecoration('Alias...'),
                        validator: validateFormField),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Designation",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateFormField,
                      hint: const Text("Select Designation"),
                      value: isEditMode ? teacher!.designation : null,
                      isExpanded: true,
                      iconSize: 40.0,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDesignation = newValue;
                        });
                      },
                      items: teacherDesignation
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Contact No",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue:
                            isEditMode ? teacherNumber.toString() : '',
                        onChanged: (value) {
                          teacherNumber = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration: FormHelper.formFieldDecoration('0300...'),
                        validator: validateFormField),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Email ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: isEditMode ? teacherEmail : '',
                        onChanged: (value) {
                          teacherEmail = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration:
                            FormHelper.formFieldDecoration('abc@xyz.com'),
                        validator: validateFormField),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('cancel')),
              TextButton(
                onPressed: () {
                  if (formValidate()) {
                    Teacher newTeacher = Teacher(
                        id: isEditMode ? teacher!.id : "",
                        name: teacherName.toString(),
                        facultyNo: teacherFacultyName.toString(),
                        alias: teacherAlias.toString(),
                        designation: selectedDesignation.toString(),
                        emailId: teacherEmail.toString(),
                        contactNumber: teacherNumber!.toInt());
                    if (isEditMode) {
                      myProgressBar();
                      updateTeacerData(newTeacher);
                    } else {
                      myProgressBar();
                      enterTeacherData(newTeacher);
                    }
                  }
                },
                child: Text(isEditMode ? "update" : "submit"),
              ),
            ],
          );
        });
  }

  // method to geta data from teacher's collection from firebse
  Stream<List<Teacher>> getTeachersData() {
    return FirebaseFirestore.instance.collection("teachers").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Teacher.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: StreamBuilder<List<Teacher>>(
                  stream: getTeachersData(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      print("Snapshor Error: ${snapshot.error}");
                    }
                    if (snapshot.hasData) {
                      final teachers = snapshot.data;
                      final List<String> dataColumn = [
                        'Name',
                        'Faculty No',
                        'Alias',
                        'Designation',
                        'Email',
                        'Contact No',
                        'Edit',
                        'Delete'
                      ];
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                              sortAscending: sortAscending,
                              sortColumnIndex: sortColumnIndex,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                              columns: buildColumn(dataColumn),
                              rows: buildRow(teachers)),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  }),
                ),
              ),
            ),
            GestureDetector(
              onTap: (() {
                createAlertDialog(context);
              }),
              child: FormHelper.inputbButton(
                text: 'Add New Teacher',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
