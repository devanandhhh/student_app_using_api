import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc/bloc/add_student_bloc.dart';
import 'package:mini_bloc/core/constant.dart';
import 'package:mini_bloc/model/model.dart';
import 'package:mini_bloc/screens/view_screen.dart';
import 'package:mini_bloc/screens/widgets/student_edit.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.data});
  final Student data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 80,
        decoration:
            BoxDecoration(borderRadius: borderR20, color: Colors.yellow[100]),
        child: Row(
          children: [
            kwidth10,
            BlocBuilder<AddStudentBloc, AddStudentState>(
              builder: (context, state) {
                return Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.amber[200],
                      borderRadius: borderR20,
                      image: DecorationImage(
                          image: NetworkImage(data.image!), fit: BoxFit.cover)),
                );
              },
            ),
            kwidth10,
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name, style: textStyleblac),
                  Text(
                    data.department,
                    style: textStyleblac,
                  )
                ],
              ),
            ),
            kwidth120,
            PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                  size: 36,
                ),
                itemBuilder: (ctx) {
                  return [
                    PopupMenuItem(
                      child: const Text('View'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ViewScreen(
                                      data: data,
                                    )));
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Edit '),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return StudentEditOption(
                                data: data,
                              );
                            });
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Delete'),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text(
                                    'Are You Sure ,You want to Delete'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        context.read<AddStudentBloc>().add(
                                            DeleteStudentEvent(
                                                studentId:
                                                    int.parse(data.id!)));
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                kSnakbar('Delete Sucessfully'));
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'))
                                ],
                              );
                            });
                      },
                    )
                  ];
                })
          ],
        ),
      ),
    );
  }
}
