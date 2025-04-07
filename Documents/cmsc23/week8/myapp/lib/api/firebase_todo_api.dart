import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_model.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllTodos() {
    return db.collection('todos').snapshots();
  }

  Future<String> addTodo(Map<String, dynamic> todo)  async {
    try {
      await db.collection('todos').add(todo);
      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return 'Error on ${e.message}';
    }
  }

  Future<String> deleteTodo(String id) async {
    try {
      await db.collection('todos').doc(id).delete();
      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return 'Error on ${e.message}';
    }
  }

  Future<String> editTodo(String id, Todo item) async {
    try {
      await db.collection('todos').doc(id).update({'title':item.title});
      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      return 'Error on ${e.message}';
    }
  }

}