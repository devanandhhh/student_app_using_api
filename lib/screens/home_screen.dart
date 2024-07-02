import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc/bloc/add_student_bloc.dart';
import 'package:mini_bloc/core/constant.dart';
import 'package:mini_bloc/screens/add_student.dart';
import 'package:mini_bloc/screens/demo.dart';
import 'package:mini_bloc/screens/view_screen.dart';
import 'package:mini_bloc/screens/widgets/student_card.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddStudentBloc>().add(GetAllStudentEvent());
    return Scaffold(
      appBar: AppBar(
        title:  GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const DemoPage()));
          },
          child:const Text(
            'Home Screen',
            style: appbarstyle,
          ),
        ),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: CupertinoSearchTextField(
              onChanged: (value) {
                context
                    .read<AddStudentBloc>()
                    .add(SearchStudentEvent(searchQuery: value));
              },
              backgroundColor: Colors.grey.withOpacity(0.5),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.grey,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: BlocBuilder<AddStudentBloc, AddStudentState>(
              builder: (context, state) {
                if (state is StudentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is EmptyStudentState) {
                  return const Center(
                    child: Text('No Students found'),
                  );
                } else if (state is FetchAllStudentState) {
                  return ListView.separated(
                    itemCount: state.allstudent.length,
                    itemBuilder: ((context, index) {
                      final studentData = state.allstudent[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          child: StudentCard(
                            data: studentData,
                          ),
                          onDoubleTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ViewScreen(
                                        data: studentData,
                                      ))),
                        ),
                      );
                    }),
                    separatorBuilder: (context, index) => kheight20,
                  );
                }
                if (state is ErrorState) {
                  return const Center(
                    child: Text('Student List is Empty'),
                  );
                } else {
                  return const Center(
                    child: kheight20,
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const AddStudent()));
          },
          backgroundColor: Colors.amber[200],
          child: iconAdd),
    );
  }
}
