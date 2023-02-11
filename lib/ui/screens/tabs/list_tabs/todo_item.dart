import 'package:flutter/material.dart';
import 'package:to_do_list/models/todoDM.dart';

class TodoItem extends StatelessWidget {
  TodoDM todo;
  TodoItem(this.todo);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
      color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 50,
            color: Theme.of(context).primaryColor,
          ),
          Spacer(flex: 1,),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(todo.title,style: Theme.of(context).textTheme.titleMedium),
              Text(todo.description,style: Theme.of(context).textTheme.titleSmall)
            ],),
          ),
          Spacer(flex: 2,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
            child: Image.asset("assets/images/icon_check.png"),
          )
        ],
      ),
    );
  }
}
