
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine/pages/bottomsheet/bottomsheet+permission.dart';
import 'package:medicine/main.dart';
import 'package:medicine/models/hiveStorage_medicine.dart';
import 'package:medicine/pages/bottomsheet/time_bottomsheet.dart';
import 'package:medicine/services/addingMedicine_service.dart';
import 'package:medicine/services/file_service.dart';
import 'components/BasicPageBodyFormet.dart';




class AddAlarmPage extends StatelessWidget {
   AddAlarmPage ({ 
    Key? key, 
    required this.medicineImage, 
    required this.medicineName })
     : super(key: key);

final File? medicineImage;
final String medicineName;

  
 final service = AddMedicineService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BasicPageBodyFormet(
        
        children: [
         Text('Dont forget today medicine!', style: Theme.of(context).textTheme.headline4,),
         SizedBox (height: 40),
         Expanded(
           child: AnimatedBuilder(
             animation: service,
             builder: (context,_) {
               return ListView(
                 children: alarmWidgets,
                  
                 

          

               );
             }, 
           ),)

        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,)
,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,),
              onPressed: () async {
                    bool  result =false;

                    //1. add alarm
                    for (var alarm in service.alarms) {
                
                      result= await notification.addNotifcication(
                      medicineId: medicineRepository.newId,
                      alarmTimeStr: alarm ,
                      title: '$alarm time to take medicine!', 
                      body:'Tell me if you took $medicineName !',   
                      );
                      if(!result){
                            return showPermissionDenied(context, permission: 'Alarm');
                      }
                    }
                    
                    //2. save image
                    String? imagefilePath;
                    if(medicineImage!=null){
                    imagefilePath= await saveImageToLocalDirectory(medicineImage!);
                    }

                    //3. add medicine model
                    final medi= Medicine(
                      id: medicineRepository.newId, 
                      name: medicineName, 
                      imagePath: imagefilePath, 
                      alarms: service.alarms.toList(),
                      );
                      medicineRepository.addMedicine(medi);

                      Navigator.pop(context);
                      Navigator.pop(context);
                      
              },
           
              child: Text('Submit')
              ),
          ),
        ),
      ),
    );
    
  }

List<Widget> get alarmWidgets {
            final children = <Widget> [];
            children.addAll(service.alarms.map((alarmTime) => AlarmBox(
                time: alarmTime, services: service,
               

                 
            ),
            ),
            );
            children.add(AddAlarmButton(
              service: service,  
            ));
            return children;
          }
}












class AlarmBox extends StatelessWidget {
  const AlarmBox({
    Key? key, required this.time, required this.services,
  }) : super(key: key);

  final String time;
  final AddMedicineService services;

  @override
  Widget build(BuildContext context) {
    final initTime =DateFormat('HH:mm').parse(time);

    return Row(children: [
      IconButton(onPressed: (){
        services.remomeAlarm(time);

      }
        
      , icon: Icon(CupertinoIcons.minus_circle),
      ),

      TextButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context){
          return TimeSettingBottomSheet(
             initialTime: time ,
          );
          
          }
          ).then((value) {
            if(value==null || value is !DateTime) return; //예외처리 데이터타입이랑 널값 고려
            services.setAlarm(setTime: value, prevTime: time,
                  );
          });
      }, 
      child: Text(time),
       )
    ],);
  }
}

// ignore: must_be_immutable
