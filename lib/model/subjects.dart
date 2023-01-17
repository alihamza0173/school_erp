class Subject {
  String id, subjectName, subjectCode, department, courseType;
  int semester;

  Subject(
      {required this.id,
      required this.subjectName,
      required this.subjectCode,
      required this.department,
      required this.courseType,
      required this.semester,});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_name': subjectName,
      'subject_code': subjectCode,
      'department': department,
      'course_type': courseType,
      'semester': semester,
    };
  }

  static Subject fromJson(Map<String, dynamic> json) {
    return Subject(
        id: json['id'],
        subjectName: json['subject_name'],
        subjectCode: json['subject_code'],
        department: json['department'],
        courseType: json['course_type'],
        semester: json['semester'],);
  }
}
