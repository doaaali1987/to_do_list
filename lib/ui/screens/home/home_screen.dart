import 'package:flutter/material.dart';
import 'package:to_do_list/ui/bottom_sheet/add_bottom_sheet.dart';
import 'package:to_do_list/ui/screens/tabs/list_tabs/list_tab.dart';
import 'package:to_do_list/ui/screens/tabs/settings_tab.dart';

class HomeScreen extends StatefulWidget {
static String routeName="Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<Widget> tabs=[ListTab(),SettingsTab()];

int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*.1,
        title: const Text("To Do list"),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side:BorderSide(
            color: Colors.white,
            width: 3,
          )
        ),
        onPressed: (){
          showAddBottomSheet();
        },
        child: Icon(Icons.add,
        color: Colors.white,)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          onTap: (index)
          {
            currentIndex=index;
            setState(() {
            });
          },
           items: [
             const BottomNavigationBarItem(
               icon:ImageIcon(AssetImage('assets/images/icon_list.png')),
               label:"list"
             ),
             const BottomNavigationBarItem(
                 icon:ImageIcon(AssetImage('assets/images/icon_settings.png')),
               label: "Settings"
             )
           ],
        ),
      ),
      body: tabs[currentIndex],

    );
  }

  void showAddBottomSheet() {
    showModalBottomSheet(context: context, builder: (_){
      return AddBottomSheet();
    });
  }
}
