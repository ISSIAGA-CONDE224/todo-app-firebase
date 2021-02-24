import 'package:flutter/cupertino.dart';
import 'package:todo_app_firestore_example/api/firebase_api.dart';
import 'package:todo_app_firestore_example/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

// ici j'accède à tous les todos qui ne sont pas cochés
  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

//Ici j'ai fait l'inverse de la méthode ci-dessus
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  // methode d'ajout de todo. Mais j'accede  à cette fonction via ma classe FirebaseApi
  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  // methode de suppression de todo. Mais j'accede  à cette fonction via ma classe FirebaseApi
  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  //fonction qui change l'etat d'un todo, s'il est coché ou pas (true || false)
  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

//fonction de mise à jour du todo
  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }
}
