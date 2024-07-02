
class Student {
  final String? id;
  final String name;
  final String rollno;
  final String age;
  final String department;
  final String phone;
  final String? image;

  Student(
      {this.id,
      required this.name,
      required this.rollno,
      required this.age,
      required this.department,
      required this.phone,
      this.image});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        name: json['name'],
        rollno: json['roll_no'],
        age: json['age'],
        department: json['department'],
        phone: json['phone'],
        image: json['image']);
  }

  Student copyWith(
      {String? name,
      String? department,
      String? rollno,
      String? phone,
      String? age}) {
    return Student(
      name: name ?? this.name,
      rollno: rollno ?? this.rollno,
      age: age ?? this.age,
      department: department ?? this.department,
      phone: phone ?? this.phone,
    );
  }
}
