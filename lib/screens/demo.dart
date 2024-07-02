import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_bloc/bloc/add_student_bloc.dart';
import 'package:mini_bloc/model/model.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddStudentBloc>().add(PrintAllStudentEvent());
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AddStudentBloc, AddStudentState>(
        listener: (context, state) {
          if (state is PrintAllstudentSucessState) {
            log('================================='); 
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('data fetched'),backgroundColor: Colors.green,));
          }
        },
        builder: (context, state) {
          if(state is PrintAllstudentLoadingState){
            return const Center(child:  CircularProgressIndicator(),);
          }else if(state is PrintAllstudentSucessState){
                
              return ListView.builder(itemBuilder: (context, index) {
                Student student =state.studentList[index];
                return ListTile(title: Text(student.name),subtitle: Text(student.age),);
              },
              itemCount: state.studentList.length,);
          }else if(state is PrintAllStudentEmptyState){
            return const Center(child: Text('Empty'),);
          }else{
            return const Text('not found');
          }
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }
class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flexible Example'),
        ),
        body: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.red,
                height: 100,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.green,
                height: 100,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.blue,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expanded Example'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: 100,
            ),
            Expanded(
              child: Container(
                color: Colors.green,
              ),
            ),
            Container(
              color: Colors.blue,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:const Text('Expanded vs Flexible'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(color: Colors.red, width: 100, height: 100),
                Expanded(
                  child: Container(color: Colors.blue, height: 100),
                ),
                Container(color: Colors.red, width: 100, height: 100),
              ],
            ),
            Row(
              children: [
                Container(color: Colors.red, width: 100, height: 100),
                Flexible(
                  child: Container(color: Colors.green, height: 100),
                ),
                Container(color: Colors.red, width: 100, height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
