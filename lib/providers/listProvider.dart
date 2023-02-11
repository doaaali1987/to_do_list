
import 'package:flutter/material.dart';
import 'package:to_do_list/models/todoDM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/utilities/constants.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDM> todos = [];
  DateTime selectedDay = DateTime.now();
  
  fetchTodoFromFireStore() async //Function to get data from firestore
      {
    var todosCollection =
    FirebaseFirestore.instance.collection(TodoDM.collectionName);
    var query = await todosCollection
        .get(); //to get list of todos,await for get all todos in firebase
    ///will return list of docs w ana 3yza list of todos(title,desc,...)
    ///To convert from list of docs to list of todos,we use map
    todos = query.docs.map((doc) {
      var map = doc.data(); //kda ma3ana el map feha el id,title,time,....
      ///to get id,title,.. from map we will replace Step#1 wz Step#2 (items in constants files)
      //return TodoDM(id:id,title: title, time: time, description: description, isDone: isDone); Step#1
      return TodoDM(
          id: map[idKey],
          title: map[titleKey],
          time: DateTime.fromMillisecondsSinceEpoch(map[dateTimeKey]),
          description: map[descriptionKey],
          isDone: map[isDoneKey]); //Step#2
    }).toList(); //kda 3ndna list of todos we can view it in the app
    ///Filter wz selected date
    todos = todos.where((todo) {
      return todo.time.year == selectedDay.year &&
          todo.time.month == selectedDay.month &&
          todo.time.day == selectedDay.day;
    }).toList();
    ///To sort list by date
    todos.sort((todo1,todo2){
      return todo1.time.compareTo(todo2.time);
    });
    notifyListeners();
  }
  changeSelectedDate(DateTime newDate)
  {
    selectedDay=newDate;
    //notifyListeners();
    fetchTodoFromFireStore();
  }
}