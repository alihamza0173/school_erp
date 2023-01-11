import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetTeacherData extends StatelessWidget {
  final String teacherId;
  const GetTeacherData({required this.teacherId, super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference teachers = FirebaseFirestore.instance.collection("teachers");

    return FutureBuilder<DocumentSnapshot>(
      future: teachers.doc(teacherId).get(),
      builder: ((context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data = 
        snapshot.data!.data() as Map<String, dynamic>;
        return Text("Name: ${data['name']}");
      }
      return const Text("loading..");
    }));
  }
}