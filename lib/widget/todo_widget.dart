import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore_example/model/todo.dart';
import 'package:todo_app_firestore_example/page/edit_todo_page.dart';
import 'package:todo_app_firestore_example/provider/todos.dart';
import 'package:todo_app_firestore_example/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            IconSlideAction(
                icon: Icons.edit,
                color: Colors.green,
                caption: 'Modifier',
                onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'AVERTISSEMENT !',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          content: const Text('Voulez-vous Modifier ?'),
                          actions: [
                            FlatButton(
                              child: Text('OUI'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                editTodo(context, todo);
                              },
                            ),
                            FlatButton(
                              child: Text('NON'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                //deleteTodo(context, todo);
                              },
                            )
                          ],
                        );
                      },
                    ) //() => editTodo(context, todo),
                )
          ],
          secondaryActions: [
            IconSlideAction(
                icon: Icons.delete,
                caption: 'Supprimer',
                color: Colors.red,
                onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'AVERTISSEMENT !',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          content: const Text('Voulez-vous supprimer ?'),
                          actions: [
                            FlatButton(
                              child: Text('OUI'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                deleteTodo(context, todo);
                              },
                            ),
                            FlatButton(
                              child: Text('NON'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                //deleteTodo(context, todo);
                              },
                            )
                          ],
                        );
                      },
                    )
                // () => deleteTodo(context, todo),
                )
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  Utils.showSnackBar(
                    context,
                    isDone
                        ? 'Tâches terminée avec succes'
                        : 'Tâche non terminée',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    !todo.isDone
                        ? Text(
                            todo.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22),
                          )
                        : Text(
                            todo.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 22),
                          ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Tâche supprimée');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
