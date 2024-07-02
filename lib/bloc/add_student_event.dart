part of 'add_student_bloc.dart';

abstract class AddStudentEvent {}

class SelectImageEvent extends AddStudentEvent {}

class ClearImageEvent extends AddStudentEvent {}

class GetAllStudentEvent extends AddStudentEvent {}

class CreateStudentEvent extends AddStudentEvent {
  final Student student;
  CreateStudentEvent(this.student);
}

class EditStudentEvent extends AddStudentEvent {
  final int studentId;
  final Student student;
  EditStudentEvent({required this.studentId, required this.student});
}

class ErrorStudentEvent extends AddStudentEvent {}

class DeleteStudentEvent extends AddStudentEvent {
  final int studentId;
  DeleteStudentEvent({required this.studentId});
}

class SearchStudentEvent extends AddStudentEvent {
  final String searchQuery;
  SearchStudentEvent({required this.searchQuery});
}

////////////////////////////////////////////////





class PrintAllStudentEvent extends AddStudentEvent{



}





