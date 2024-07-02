import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc/bloc/add_student_bloc.dart';
import 'package:mini_bloc/core/constant.dart';
import 'package:mini_bloc/model/model.dart';
import 'package:mini_bloc/screens/home_screen.dart';
import 'package:mini_bloc/screens/widgets/others.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStudentBloc(),
      child: const AddStudentFormState(),
    );
  }
}

// ignore: must_be_immutable
class AddStudentFormState extends StatefulWidget {
  const AddStudentFormState({super.key});

  @override
  State<AddStudentFormState> createState() => _AddStudentFormStateState();
}

class _AddStudentFormStateState extends State<AddStudentFormState> {
  final formkey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();

  final rollnocontroller = TextEditingController();

  final agecontroller = TextEditingController();

  final departmentcontroller = TextEditingController();

  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Student',
          style: appbarstyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                kheight20,
                CircleAvatar(
                  backgroundColor: Colors.amber[200],
                  radius: 78,
                  child: GestureDetector(onTap: () async {
                    context.read<AddStudentBloc>().add(SelectImageEvent());
                  }, child: BlocBuilder<AddStudentBloc, AddStudentState>(
                    builder: (context, state) {
                      return state is ImagePickingState
                          ? CircleAvatar(
                              backgroundColor: Colors.amber[200],
                              radius: 75,
                              backgroundImage: FileImage(File(state.imagepath)),
                            )
                          : const Center(
                              child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                              size: 30,
                            ));
                    },
                  )),
                ),
                kheight20,
                Ktextfield(
                  limit: false,
                  type: TextInputType.name,
                  namecontroller: namecontroller,
                  hintText: 'Student Name',
                  errorMsg: 'Name is required',
                  kIcon: Icons.person,
                ),
                kheight20,
                Ktextfield(
                  limit: false,
                  type: TextInputType.number,
                  namecontroller: rollnocontroller,
                  hintText: 'Roll Number',
                  errorMsg: 'Roll No is required',
                  kIcon: Icons.roller_shades,
                ),
                kheight20,
                Ktextfield(
                  limit: false,
                  type: TextInputType.number,
                  namecontroller: agecontroller,
                  hintText: 'Age',
                  errorMsg: 'Age is Required',
                  kIcon: Icons.access_time_sharp,
                ),
                kheight20,
                Ktextfield(
                  limit: false,
                  type: TextInputType.name,
                  namecontroller: departmentcontroller,
                  hintText: 'Department',
                  errorMsg: 'Department is required',
                  kIcon: Icons.place,
                ),
                kheight20,
                Ktextfield(
                  limit: true,
                  type: TextInputType.number,
                  namecontroller: phonecontroller,
                  hintText: 'Phone Number',
                  errorMsg: 'phone number is required',
                  kIcon: Icons.numbers,
                ),
                kheight20,
                BlocBuilder<AddStudentBloc, AddStudentState>(
                  builder: (context, state) {
                    return Material(
                      child: GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            if (state is ImagePickingState) {
                              Student student = Student(
                                  name: namecontroller.text,
                                  rollno: rollnocontroller.text,
                                  age: agecontroller.text,
                                  department: departmentcontroller.text,
                                  phone: '+91${phonecontroller.text}',
                                  image: state.imagepath);
                              context
                                  .read<AddStudentBloc>()
                                  .add(CreateStudentEvent(student));
                              // context
                              //     .read<AddStudentBloc>()
                              //     .add(GetAllStudentEvent());
                            }
                            context
                                .read<AddStudentBloc>()
                                .add(ClearImageEvent());

                            namecontroller.clear();
                            departmentcontroller.clear();
                            agecontroller.clear();
                            phonecontroller.clear();
                            rollnocontroller.clear();
                           //Navigator.pop(context); 
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (ctx) => const HomeScreen()),
                                (route) => false);
                                
                            ScaffoldMessenger.of(context).showSnackBar(
                               kSnakbar('Data Added successfully'));
                          }
                        },
                        // Navigator.Color.fromARGB(255, 19, 18, 15);
                        child: saveButton(text: 'Save'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

