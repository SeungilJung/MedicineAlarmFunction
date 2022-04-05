
 //import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
 
import 'package:medicine/main.dart';
//import 'package:hive_flutter/adapters.dart';
import 'package:medicine/models/object_medicine_alarm.dart';
import 'package:medicine/models/hiveStorage_medicine_log.dart';
//import 'package:medicine/pages/bottomsheet/time_setting_bottomsheet.dart';
import 'package:medicine/pages/today/today-taken-time.dart';
import '../../models/hiveStorage_medicine.dart';

class TodayPage extends StatelessWidget {
  TodayPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today medicine List',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: medicineRepository.medicineBox.listenable(),
            builder: _builderMedicineListView
          ),
        ),

      ],
    );
  }

  Widget _builderMedicineListView(context,Box<Medicine> box,_) {
    final medicines = box.values.toList();
    final medicineAlarms= <MedicineAlarm>[];

     
    
    for (var medicine in medicines) {
      for (var alarm in medicine.alarms) {
        medicineAlarms.add(MedicineAlarm(
          medicine.id,
          medicine.name,
          medicine.imagePath,
          alarm,
          medicine.key,
        ));
      }
    }

   
    
         return Column(
      children: [
        const Divider(height: 1, thickness: 1.0),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: medicineAlarms.length,
            itemBuilder: (context, index) {
              return _buildListTile(medicineAlarms[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 20,
              );
            },
          ),
        ),
        const Divider(height: 1, thickness: 1.0),
      ],
    );



  }






  Widget _buildListTile(MedicineAlarm medicineAlarm) {
    return ValueListenableBuilder(

      valueListenable: historyRepository.historyBox.listenable(),
      builder: (context, Box<MedicineHistory> historyBox, _) {
        if (historyBox.values.isEmpty) {
          return BeforeTile(
            medicineAlarm: medicineAlarm,
          );
        }
      
      

        final todayTakeHistory = historyBox.values.singleWhere(
          (history) =>
              history.medicineid == medicineAlarm.id &&
              history.medicineKey==medicineAlarm.key &&
              history.alarmTime == medicineAlarm.alarmTime &&
              isToday(history.takeTime, DateTime.now()),

            orElse: () => MedicineHistory(    
            medicineid: -1,
            alarmTime: '',
            takeTime: DateTime.now(), 
            medicineKey: -1,
            imagePath: null,
            name:"",
          ),
        );


        if(todayTakeHistory.medicineid ==-1 /*&& todayTakeHistory.alarmTime ==''*/){
            return BeforeTile(
            medicineAlarm: medicineAlarm,
          );
        }
         return AfterTile(
            history: todayTakeHistory,
            medicineAlarm: medicineAlarm,         
      );
    
      }
      );
  }
}
 
bool isToday(DateTime source, DateTime destination) {
  return source.year == destination.year &&
      source.month == destination.month &&
      source.day == destination.day;
  }


  