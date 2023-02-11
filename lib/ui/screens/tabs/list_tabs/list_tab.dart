import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/todoDM.dart';
import 'package:to_do_list/providers/listProvider.dart';
import 'package:to_do_list/ui/screens/tabs/list_tabs/todo_item.dart';
import 'package:to_do_list/utilities/constants.dart';
import 'package:to_do_list/utilities/theme_helper.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  ///after ChangeProviderWidget in main.dart
  late ListProvider listProvider;
  ///To show the selected date no time now
  //>>>DateTime selectedDay = DateTime.now();  el line dh ra7 fe listProvider.dart

  ///after we create fetchTodoFromFireStore(),we code the below step and if(todos.isEmpty)
  //>>>List<TodoDM> todos = []; el line dh ra7 fe listProvider.dart

  ///show design lw mfesh tasks saved before
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    if (listProvider.todos.isEmpty)    //before using provider>>if (todos.isEmpty)
      listProvider.fetchTodoFromFireStore();        //before using provider>>fetchTodoFromFireStore();
    return Container(
      child: Column(
        children: [
          ///wrap wz Stack widget to design calender on the appBar
          CalendarTimeline(
            ///Bug:A RenderFlex overflowed by 2.0 pixels on the bottom SO we added shrink wz true
            shrink: true,
            //showYears: true,
            //initialDate: DateTime(2020, 4, 20),
            initialDate: listProvider.selectedDay,   //before provider>>initialDate: selectedDay,

            ///Show year before and year after
            //firstDate: DateTime(2019, 1, 15),
            firstDate: listProvider.selectedDay.subtract(Duration(days: 365)),  //before provider>>firstDate: selectedDay.subtract(Duration(days: 365)),
            //lastDate: DateTime(2020, 11, 20),
            lastDate: listProvider.selectedDay.add(Duration(days: 365)), //before provider>>lastDate: selectedDay.add(Duration(days: 365)),
            //onDateSelected: (date) => print(date),
            onDateSelected: (date) {
              listProvider.changeSelectedDate(date);    //before changeselectedDate()>>listProvider.selectedDay = date;  //before provider>>selectedDay = date;
              setState(() {});  //will remove it coz using provider
              listProvider.fetchTodoFromFireStore();         //before provider>>fetchTodoFromFireStore();
            },
            leftMargin: 20,
            monthColor: Theme.of(context).primaryColor,
            dayColor: Theme.of(context).primaryColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Theme.of(context).primaryColor,
            //dotsColor: Color(0xFF333A47),
            ///If you want a day is unselected
            //selectableDayPredicate: (date) => date.day != 23,
            //locale: 'en_ISO',
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              //itemCount: 10,
              itemCount: listProvider.todos.length,   //before provider>>itemCount: todos.length,
              itemBuilder: (_, index) {
                ///in past we view static items for todos ,
                ///but after fetchTodoFromFireStore(),we will comment the below step and show todos from firebase
                // return TodoItem(TodoDM(
                //     title: "Played football",
                //     time: DateTime.now(),
                //     description: "Description",
                //     isDone: true));
                return TodoItem(listProvider.todos[index]);   //before provider>>return TodoItem(todos[index]);
              },
            ),
          )
        ],
      ),
    );
  }

//>>>Hena kant fetchTodoFromFireStore() w move to listProvider.dart

}
