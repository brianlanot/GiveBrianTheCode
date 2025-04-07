import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/firebase_todo_api.dart';
import '../../../../../models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _todosStream;
  late FirebaseTodoAPI firebaseService;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todo => _todosStream;

  // TODO: get all todo items from Firestore
  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  // TODO: add todo item and store it in Firestore
  Future<void> addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson());
    print(message);
    notifyListeners();
  }

  // TODO: edit a todo item and update it in Firestore
  Future<void> editTodo(String id, String newTitle, bool currentStatus) async {
    Todo updatedItem = Todo(title: newTitle, completed: currentStatus); // construct a Todo object
    String message = await firebaseService.editTodo(id, updatedItem);
    print(message);
  notifyListeners();
  }

  // TODO: delete a todo item and update it in Firestore
  Future<void> deleteTodo(String id) async {
    String message = await firebaseService.deleteTodo(id);
    print(message);
    notifyListeners();
  }

  // TODO: modify a todo status and update it in Firestore
  Future<void> toggleStatus(String id, bool status) async {
    notifyListeners();
  }
}
