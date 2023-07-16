import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_flutter/models/todo.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({required this.firestore});

  Stream<List<ToDoModel>> streamToDos({required String uid}) {
    try {
      return firestore
          .collection('todos')
          .doc(uid)
          .collection('todos')
          .where('isChecked', isEqualTo: false)
          .snapshots()
          .map((query) {
        List<ToDoModel> retVal = [];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(
            ToDoModel.fromDocumentSnapshot(documentSnapshot: doc),
          );
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToDo({required String uid, required String title}) async {
    try {
      firestore.collection('todos').doc(uid).collection('todos').add({
        'title': title,
        'isChecked': false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateToDo({required String uid, required String todoId}) async {
    try {
      firestore
          .collection('todos')
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .update(
            ({
              'isChecked': true,
            }),
          );
    } catch (e) {
      rethrow;
    }
  }
}
