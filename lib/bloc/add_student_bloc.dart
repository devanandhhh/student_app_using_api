import 'dart:async';
import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:mini_bloc/api/api_services.dart';
import 'package:mini_bloc/model/model.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  Api api = Api();
  AddStudentBloc() : super(AddStudentInitial()) {
    on<PrintAllStudentEvent>(printAllStudentEvent);

    on<CreateStudentEvent>((event, emit) async {
      emit(StudentLoading());
      await api.createStudent(event.student);
      final List<Student> updatedStudent = await api.getAllStudent();
      if (updatedStudent.isNotEmpty) {
        emit(FetchAllStudentState(allstudent: updatedStudent));
      }
    });

    on<SelectImageEvent>(takeImageEvent);

    on<ClearImageEvent>(
      (event, emit) {
        emit(AddStudentInitial());
      },
    );

    on<DeleteStudentEvent>((event, emit) async {
      await api.deleteStudent(event.studentId);
      final List<Student> updatedStudent = await api.getAllStudent();
      emit(FetchAllStudentState(allstudent: updatedStudent));
    });

    on<GetAllStudentEvent>((event, emit) async {
      emit(StudentLoading());
      try {
        final List<Student> student = await api.getAllStudent();
        if (student.isEmpty) {
          emit(EmptyStudentState());
        } else {
          log(student.length);
          emit(FetchAllStudentState(allstudent: student));
        }
      } catch (e) {
        print(e);
      }
    });

    on<EditStudentEvent>((event, emit) async {
      await api.editstudent(event.studentId, event.student);
      final List<Student> updatedStudent = await api.getAllStudent();
      emit(FetchAllStudentState(allstudent: updatedStudent));
    });

    on<SearchStudentEvent>((event, emit) async {
      try {
        if (event.searchQuery.isEmpty) {
          emit(StudentLoading());
          final List<Student> student =
              await api.getAllStudent(); //-------------
          emit(FetchAllStudentState(allstudent: student));
        } else {
          emit(StudentLoading());
          final List<Student> updatestudent =
              await api.searchStudent(searchquery: event.searchQuery);
          emit(FetchAllStudentState(allstudent: updatestudent));
        }
      } catch (e) {
        print('errro :$e');
        throw Exception('error :$e');
      }
    });
  }
  FutureOr<void> takeImageEvent(
      SelectImageEvent event, Emitter<AddStudentState> emit) async {
    final pickfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickfile != null) {
      emit(ImagePickingState(imagepath: pickfile.path));
    }
  }

  FutureOr<void> printAllStudentEvent(
      PrintAllStudentEvent event, Emitter<AddStudentState> emit) async {
    emit(PrintAllstudentLoadingState());
    List<Student> getStudents = await api.getAllStudent();
    if (getStudents.isNotEmpty) {
      emit(PrintAllstudentSucessState(studentList: getStudents));
    } else if (getStudents.isEmpty) {
      emit(PrintAllStudentEmptyState());
    } else {
      emit(PrintAllStudentErrorState());
    }
  }
}
