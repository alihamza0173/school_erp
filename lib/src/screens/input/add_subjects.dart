import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_erp/model/subjects.dart';

import '../../styles/app_color.dart';
import '../../styles/app_text_style.dart';

class AddSbujects extends StatefulWidget {
  const AddSbujects({super.key});

  @override
  State<AddSbujects> createState() => _AddSbujectsState();
}

class _AddSbujectsState extends State<AddSbujects> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? checkTextFieldValidation(value) {
    if (value == null || value.isEmpty) {
      return "Required";
    } else {
      return null;
    }
  }

  bool validateForm() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String? selectedCourseType;
  int? selectedSemester;
  String? selectedDepartment;
  final _subjectNameTextControler = TextEditingController();
  final _subjectCodeTextControler = TextEditingController();

  @override
  void dispose() {
    _subjectNameTextControler.dispose();
    _subjectCodeTextControler.dispose();
    super.dispose();
  }

  void clearTextFields() {
    _subjectCodeTextControler.clear();
    _subjectNameTextControler.clear();
  }

  List<String> courseType = [
    'THEORY',
    'LAB',
  ];

  List<int> semestersList = [1, 2, 3, 4, 5, 6, 7, 8];

  List<String> departmentsList = [
    'Computer Science',
    'Software Engeeniring',
    'Information Technology',
  ];

  List<DataColumn> buildColumn(List<String> column) {
    return column
        .map((e) => DataColumn(
            label: Text(e)))
        .toList();
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

  List<DataRow> buildRow(List<Subject>? subjects) {
    return subjects!
        .map((e) => DataRow(cells: [
              DataCell(Text(e.subjectCode)),
              DataCell(Text(e.subjectName)),
              DataCell(Text('${e.semester}')),
              DataCell(Text(e.department)),
              DataCell(Text(e.courseType)),
              DataCell(
                Icon(
                  Icons.edit,
                  color: Colors.green[800],
                ),
                // onTap: () {
                //   teacherName = e.name;
                //   teacherAlias = e.alias;
                //   selectedDesignation = e.designation;
                //   teacherNumber = e.contactNumber;
                //   teacherFacultyName = e.facultyNo;
                //   teacherEmail = e.emailId;
                //   createAlertDialog(context, isEditMode: true, teacher: e);
                // },
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
                                // myProgressBar();
                                // deleteTeacerData(e.id);
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

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
                height: 40.0,
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                    child: Text(
                  'Add Subject',
                  style: TextStyle(color: Colors.white),
                ))),
            content: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Subject Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _subjectNameTextControler,
                      style: AppTextStyle.style(
                        color: Colors.black.withOpacity(0.8),
                      ),
                      decoration: InputDecoration(
                        hintText: "Subject's Name...",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Subject Code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _subjectCodeTextControler,
                      style: AppTextStyle.style(
                        color: Colors.black.withOpacity(0.8),
                      ),
                      decoration: InputDecoration(
                        hintText: "CO203, CO203...",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Course Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      hint: const Text("Select Course Type"),
                      value: selectedCourseType,
                      isExpanded: true,
                      iconSize: 40.0,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCourseType = newValue;
                        });
                      },
                      items: courseType
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Semester",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      hint: const Text("Select Semester"),
                      value: selectedSemester,
                      isExpanded: true,
                      iconSize: 40.0,
                      onChanged: (newValue) {
                        setState(() {
                          selectedSemester = newValue;
                        });
                      },
                      items: semestersList
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text('$e')))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Department",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      hint: const Text("Select Department"),
                      value: selectedDepartment,
                      isExpanded: true,
                      iconSize: 40.0,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDepartment = newValue;
                        });
                      },
                      items: departmentsList
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (validateForm()) {
                      DocumentReference subjet = FirebaseFirestore.instance.collection('subjects').doc();
                      subjet.set({
                        'id': subjet.id,
                        'semester': selectedSemester,
                        'department': selectedDepartment,
                        'subject_name': _subjectNameTextControler.text,
                        'subject_code': _subjectCodeTextControler.text,
                        'course_type': selectedCourseType,
                      }).then((value) {
                        Fluttertoast.showToast(
                            msg: "Data Entered Successfuly!");
                        Navigator.pop(context);
                        clearTextFields();
                      }).onError((error, stackTrace) {
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
                      });
                    }
                  },
                  child: const Text("Submit")),
            ],
          );
        });
  }

  // method to geta data from teacher's collection from firebse
  Stream<List<Subject>> getAllSubjects() {
    return FirebaseFirestore.instance.collection("subjects").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Subject.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: StreamBuilder<List<Subject>>(
                  stream: getAllSubjects(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      print("Snapshot Error: ${snapshot.error}");
                    }
                    if (snapshot.hasData) {
                      final subjects = snapshot.data;
                      final List<String> dataColumn = [
                        'Subject Code',
                        'Subject Name',
                        'Semester',
                        'Department',
                        'Course Type',
                        'Edit',
                        'Delete'
                      ];
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                              columns: buildColumn(dataColumn),
                              rows: buildRow(subjects)),
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
                  'Add New Subject',
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
