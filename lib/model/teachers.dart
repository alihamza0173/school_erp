class Teacher {
  String id, name, facultyNo, alias, emailId, designation;
  int contactNumber;

  Teacher(
      {required this.id,
      required this.name,
      required this.facultyNo,
      required this.alias,
      required this.designation,
      required this.emailId,
      required this.contactNumber});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'faculty_no': facultyNo,
      'alias': alias,
      'designation': designation,
      'email_id': emailId,
      'contact_number': contactNumber,
    };
  }

  static Teacher fromJson(Map<String, dynamic> json) {
    return Teacher(
        id: json['id'],
        name: json['name'],
        facultyNo: json['faculty_no'],
        alias: json['alias'],
        designation: json['designation'],
        emailId: json['email_id'],
        contactNumber: json['contact_number']);
  }
}
