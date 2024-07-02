import 'dart:convert';
import 'dart:developer';

import 'package:mini_bloc/core/constant.dart';
import 'package:mini_bloc/model/model.dart';
import 'package:http/http.dart' as http;

class Api {

//for fetch student  
  Future<List<Student>> getAllStudent() async {
    final url = Uri.parse(Constant.baseUrl);
    final headers = {'x-api-key': 'apikey@studentapp'};
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            jsonDecode(response.body)['after exicution'];
        List<Student> students =
            jsonList.map((e) => Student.fromJson(e)).toList();
        return students;
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print(e);
      throw Exception('faild to fetch data $e');
    }
  }
  //================================
// for add student
  Future<void> createStudent(Student student) async {
    final url = Uri.parse(Constant.baseUrl);
    final headers = {
      'x-api-key': 'apikey@studentapp',
    };
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      request.fields['name'] = student.name;
      request.fields['roll_no'] = student.rollno;
      request.fields['age'] = student.age;
      request.fields['department'] = student.department;
      request.fields['phone'] = student.phone;
      if (student.image!.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('image', student.image!));
      }
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Student added sucessfully');
      } else {
        throw Exception('faild to create student :${response.statusCode}');
      }
    } catch (e) {
      // print(e);
      log('Error4 : $e');
      throw Exception('faildd to create student $e');
    }
  }

  Future<void> deleteStudent(int studentId) async {
    final url = Uri.parse(Constant.baseUrl);
    final header = {
      "x-api-key": "apikey@studentapp",
      "Content-Type": "application/json",
    };
    try {
      final response = await http.delete(url,
          headers: header, body: jsonEncode({'id': studentId}));
      if (response.statusCode == 200) {
        log('Student deleted ');
      } else {
        throw Exception('faild to delete student : ${response.statusCode}');
      }
    } catch (e) {
      print('error :$e');
      
      throw Exception('failed delete student : $e');
    }
  }

// for edit student
  Future<void> editstudent(int studentId, Student updatedStudent) async {
    final url = Uri.parse(Constant.baseUrl);
    final headers = {
      "x-api-key": "apikey@studentapp",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.patch(url,
          headers: headers,
          body: jsonEncode({
            'id': studentId,
            'name': updatedStudent.name,
            'roll_no':int.parse(updatedStudent.rollno) ,
            'age':int.parse(updatedStudent.age) ,
            'department': updatedStudent.department,
            'phone': updatedStudent.phone 
          }));
          log('--------------${response.statusCode}');
      if (response.statusCode == 200) {
        
      } else {
        throw Exception('faild to update : ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      
      throw Exception("Failed to update student: $e");
    }
  }

//for search Student
  Future<List<Student>> searchStudent({required String searchquery}) async {
    final url =
        Uri.parse('http://studentapp.ashkar.tech/search?q=$searchquery');
    final headers = {
      "x-api-key": "apikey@studentapp", 
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            jsonDecode(response.body)['after exicution'];
        List<Student> student =
            jsonList.map((e) => Student.fromJson(e)).toList();
        return student;
      } else {
        throw Exception('something wrong ');
      }
    } catch (e) {
      print('error :$e');
      
      throw Exception('failed to fetch student ');
    }
  }
}
