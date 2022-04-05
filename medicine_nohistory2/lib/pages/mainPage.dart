import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/pages/add_medicine/add_medicine_page.dart';
import 'package:medicine/pages/today/today_list.dart';


class Homepage extends StatefulWidget {
   Homepage ({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TodayPage(), 
      floatingActionButton: FloatingActionButton(
        onPressed:(){ Addingpage();},
        child:const Icon(CupertinoIcons.add)
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.endTop,
        bottomNavigationBar: ButtonBottomAppBar(),
    );
  }

  BottomAppBar ButtonBottomAppBar() {
    return BottomAppBar(
          child: Container(
            height: kBottomNavigationBarHeight,
            color:Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
             
              CupertinoButton(onPressed: (){
                setState(() {
                  TodayPage();
                });
                },
              child: Icon(CupertinoIcons.alarm),
              ),
              
             
        
            ],
            )),
      );
  }


  void Addingpage() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMedicinePage(),));
            }

}
