import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/database.dart';

class ToDoCard extends StatefulWidget {
  final ToDoModel toDo;
  final FirebaseFirestore firestore;
  final String uid;

  const ToDoCard({
    required this.toDo,
    required this.firestore,
    required this.uid,
    super.key,
  });

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Checkbox(
              value: widget.toDo.isChecked,
              onChanged: (newValue) {
                // setState(() {});
                Database(firestore: widget.firestore).updateToDo(
                  uid: widget.uid,
                  todoId: widget.toDo.todoId,
                );
              },
            ),
            Flexible(
              child: Text(
                widget.toDo.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
