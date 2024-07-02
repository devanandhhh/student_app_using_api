import 'package:flutter/material.dart';
import 'package:mini_bloc/core/constant.dart';
import 'package:mini_bloc/model/model.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key, required this.data});
  final Student data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Student Details',
          style: appbarstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            children: [
              kheight20,
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(data.image!),
              ),
              kheight20,
              const Text(
                'Student Name',
                style: textStylewhite,
              ),
              Text(data.name, style: textStyledec),
              kheight20,
              const Text(
                'Roll Number',
                style: textStylewhite,
              ),
              Text(data.rollno, style: textStyledec),
              kheight20,
              const Text(
                'Age',
                style: textStylewhite,
              ),
              Text(data.age, style: textStyledec),
              kheight20,
              const Text(
                'Department',
                style: textStylewhite,
              ),
              Text(data.department, style: textStyledec),
              kheight20,
              const Text(
                'Phone Number ',
                style: textStylewhite,
              ),
              Text(data.phone, style: textStyledec)
            ],
          ),
        ),
      ),
    );
  }
}
