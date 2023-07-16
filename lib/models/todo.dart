import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel {
  final String todoId;
  String title;
  bool isChecked;

  ToDoModel({
    required this.todoId,
    required this.title,
    required this.isChecked,
  });

  ToDoModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
      : todoId = documentSnapshot.id,
        title = documentSnapshot.get('title') as String,
        isChecked = documentSnapshot.get('isChecked') as bool;
}
