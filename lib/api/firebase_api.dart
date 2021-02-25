import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firestore_example/model/todo.dart';
import 'package:todo_app_firestore_example/utils.dart';

class FirebaseApi {
//toutes mes logiques sont ici qui me permetront de communiquer avec firebase et mon provider

  //cette fonction est appelée lorsque le bouton enregistrer est declencher
  static Future<String> createTodo(Todo todo) async {
    final docTodo =
        FirebaseFirestore.instance.collection('todo').doc(); //instance firebase

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());
    return docTodo.id;
  }

// methode de lecture
  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.delete();
  }
}
