part of 'add_student_bloc.dart';

@immutable
abstract class AddStudentState {}

class AddStudentInitial extends AddStudentState {}

class StudentLoading extends AddStudentState {}



class ErrorState extends AddStudentState {
  final String errormsg;
  ErrorState({required this.errormsg});
}

class EmptyStudentState extends AddStudentState {}

class FetchAllStudentState extends AddStudentState {
  final List<Student> allstudent;
  FetchAllStudentState({required this.allstudent});
}

class ImagePickingState extends AddStudentState {
  final String imagepath;
  ImagePickingState({required this.imagepath});
}

class SuccessState extends AddStudentState{}
//////////////////////////////////
///
///
///
///
class PrintAllstudentLoadingState extends AddStudentState{}


class PrintAllstudentSucessState extends AddStudentState{
final  List<Student> studentList;
  PrintAllstudentSucessState({required this.studentList});
}

class PrintAllStudentEmptyState extends AddStudentState{}

class PrintAllStudentErrorState extends AddStudentState{}