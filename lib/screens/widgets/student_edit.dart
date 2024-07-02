import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc/bloc/add_student_bloc.dart';
import 'package:mini_bloc/model/model.dart';

class StudentEditOption extends StatelessWidget {
  const StudentEditOption({super.key, required this.data});
  final Student data;
  @override
  Widget build(BuildContext context) {
    final namecontroller = TextEditingController(text: data.name);
    final rollNoController = TextEditingController(text: data.rollno);
    final ageController = TextEditingController(text: data.age);
    final departmentController = TextEditingController(text: data.department);
    final phonenumberController = TextEditingController(text: data.phone);
    return AlertDialog(
      title: const Text('Edit Student'),
      scrollable: true,
      content: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(data.image!),
          ),
          TextFormField(
            controller: namecontroller,
            decoration: const InputDecoration(label: Text('Student Name')),
          ),
          TextFormField(
            controller: rollNoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: Text('Student RollNo')),
          ),
          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: Text('Age')),
          ),
          TextFormField(
            controller: departmentController,
            decoration: const InputDecoration(label: Text('Department')),
          ),
          TextFormField(
            controller: phonenumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: Text('Phone Number')),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        BlocBuilder<AddStudentBloc, AddStudentState>(
          builder: (context, state) {
            return TextButton(
                onPressed: () {
                  int studentId = int.parse(data.id!);
                  Student student = data.copyWith(
                    name: namecontroller.text,
                    rollno: rollNoController.text,
                    age: ageController.text,
                    department: departmentController.text,
                    phone: phonenumberController.text
                  );
                  context.read<AddStudentBloc>().add(EditStudentEvent(studentId: studentId, student: student));
                  Navigator.pop(context);
                },
                child: const Text('Save'));
          },
        )
      ],
    );
  }
}
