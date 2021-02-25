import 'package:flutter/cupertino.dart';
import 'package:todo_app_firestore_example/utils.dart';




class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    @required this.createdTime,
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
  });
  //La transformation des données de firebase vers lapplication
  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
      );
//La transformation des données de l'application vers fire base
  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
