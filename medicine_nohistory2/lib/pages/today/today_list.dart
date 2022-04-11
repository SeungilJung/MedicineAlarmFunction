
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
            itemCount: medicineAlarms.length, //아이템카운트까지 전부 for문돌린것처럼 주루룩
            itemBuilder: (context, i) {
              return _buildListTile(medicineAlarms[i]);
            },
            separatorBuilder: (context, i) {
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

      valueListenable: LogRepository.LogBox.listenable(),
      builder: (context, Box<MedicineLog> LogBox, _) {
        if (LogBox.values.isEmpty) {
          return BeforeTile(
            medicineAlarm: medicineAlarm,
          );
        }
      
      

        final todayTakeLog = LogBox.values.singleWhere(
          (Log) =>
              Log.medicineid == medicineAlarm.id &&
              Log.medicineKey==medicineAlarm.key &&
              Log.alarmTime == medicineAlarm.alarmTime &&
              isToday(Log.takeTime, DateTime.now()),

            orElse: () => MedicineLog(    
            medicineid: -1,//디폴트 -1,즉 각 알람시간에 할당받은 medicine아이디값이 -1이면 아직 taketime이들어가지 않아서 medocine log데이터스토리지는 기본값,아무값없는상태
            alarmTime: '', //taketime이 입력되면 전체 medicine log데이터들이 그게 medicine log박스로 들어가서 저장됨
            takeTime: DateTime.now(), 
            medicineKey: -1,
            imagePath: null,
            name:"",
          ),
        );


        if(todayTakeLog.medicineid ==-1 /*&& todayTakeLog.alarmTime ==''*/){
            return BeforeTile(
            medicineAlarm: medicineAlarm,
          );
        }
         return AfterTile(
            Log: todayTakeLog,
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


  