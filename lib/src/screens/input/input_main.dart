import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'add_classroom.dart';
import 'add_teachers.dart';
import 'add_subjects.dart';

class InputMain extends StatefulWidget {
  const InputMain({super.key});

  @override
  State<InputMain> createState() => _InputMain();
}

class _InputMain extends State<InputMain> {
  int _selectedIndex = 0;

  List<Widget> inputPages = [
    const AddTeachers(),
    const AddSbujects(),
    const AddClassRooms(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: inputPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amberAccent,
        backgroundColor: AppColor.primary,
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
                _selectedIndex = value;
              }),
          items:  const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Teachers',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.subject), label: 'Subjects'),
            BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Classes'),
          ]),
    );
  }
}
