import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/todoDM.dart';
import 'package:to_do_list/providers/listProvider.dart';
import 'package:to_do_list/utilities/constants.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  DateTime selectedDate=DateTime.now();
  ///to save the data that had taken from text field
  String title="";
  String description="";
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height*.70, //Line added by Eng.AbdelRahman
      //padding: EdgeInsets.all(25),
      padding: EdgeInsets.all(12),
      child: Form(
        key: myKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //Line added by Eng.AbdelRahman
          children: [
            Text(
              "Add new Task",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextFormField(
              validator: (text) {
                ///trim to remove spaces
                if (text == null || text.trim().isEmpty) {
                  return "Please enter the title";
                }
              },
              decoration: InputDecoration(
                labelText: "Title",
              ),
              onChanged: (text)
              {
                title=text;
              },
            ),
            TextFormField(
              validator: (text) {
                ///trim to remove spaces
                if (text == null || text.trim().isEmpty) {
                  return "Please enter the description";
                }
              },
              minLines: 3,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description",
              ),
              onChanged: (text)
              {
                description=text;
              },
            ),
            Text(
              "Select date",
              style: Theme.of(context).textTheme.displayMedium,
              //textAlign: TextAlign.start,
            ),
            InkWell(
                onTap: () {
                  showMyDatePicker();
                },
              //child: Text("13/1/2023",style: Theme.of(context).textTheme.displaySmall,)
                child: Text("${selectedDate.year}/ ${selectedDate.month}/${selectedDate.day}",style: Theme.of(context).textTheme.displaySmall,)
            ),
            Container(
                margin: EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    myKey.currentState!.validate();
                    AddOnClick();
                  },
                  child: Text("Add"),
                ))
          ],
        ),
      ),
    );
  }
///we will convert the below function to await coz this function return future and i want to catch this return
///?? null when user open the bottom sheet and didn't choose any date so will return time.now
  void showMyDatePicker() async {
    selectedDate=await showDatePicker(
        context: context,
        //initialDate: DateTime.now(),
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))??DateTime.now();
  }

  void AddOnClick() {
    if(!myKey.currentState!.validate())return ;
    var todosCollection=FirebaseFirestore.instance.collection(TodoDM.collectionName);
    ///in the below add this collection(todosCollection.add) must involve id for collection and we don't know it so,
    ///will tell firebase to create empty doc and take new obj from this and call the default id
    var emptyDoc=todosCollection.doc();
    ///after that will set idKey to change the data in firebase
    //todosCollection.add({
    print("adding new document with id ${emptyDoc.id}");
    emptyDoc.set({   //set return future(Future has 3 call backs:then OR onError OR timeout),in this case use timeout
      idKey:emptyDoc.id,
      titleKey:title,
      descriptionKey:description,
      ///el firestore doesn't have time datatybe just stamp so we will convert it to microsecondsSinceEpoch
      dateTimeKey:selectedDate.microsecondsSinceEpoch,
      isDoneKey:false,
    }).timeout(Duration(milliseconds: 500),onTimeout: ()
    {
      listProvider.fetchTodoFromFireStore();  ///refresh
       //print("OnTime out");
      Navigator.pop(context);
    }); //line 2
    ///to close bottomsheet after added the above data
    //Navigator.pop(context); //line 1
    ///the above line had 2 problems:
    ///1-we must create local DB on mobile to avoid conflict adds from users in the same time
    ///solve:1.1-will access this data offline(close internet from firestore),
    ///so we will add line(add offline) hint in main.dart
    ///solve:1.2-will add line(unlimited cache size)hint in main.dart
    ///2-emptyDoc.set is await function
    ///solve:we will set Navigator.pop(context) in a timeout zone, so will comment line 1 and add line 2
    ///after 500 milliseconds close sheet if you can't save data in DB
  }
}

