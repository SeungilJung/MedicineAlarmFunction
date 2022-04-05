import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'bottomsheet+permission.dart';
import '../../services/addingMedicine_service.dart';

class TimeSettingBottomSheet extends StatelessWidget {
   TimeSettingBottomSheet({
    Key? key, 
     required this.initialTime, this.bottomwidget,
  }) : super(key: key);

final String initialTime;
final Widget? bottomwidget;


  @override
  Widget build(BuildContext context) {
    final initialTimeData = DateFormat('HH:mm').parse(initialTime);
    final now=DateTime.now();
    final initialDateTime=DateTime(now.year,now.month,now.day,initialTimeData.hour,initialTimeData.minute);
     DateTime setdateTime=initialDateTime;//setdatetime 초기값



      
    return BottomSheetBody(
      children: [
        SizedBox(
          height:200,
          child: CupertinoDatePicker(onDateTimeChanged: (dateTime) {
            setdateTime=dateTime;
          },
          mode: CupertinoDatePickerMode.time,
          initialDateTime: initialDateTime,)
          ),
          const SizedBox(height: 10,),
          if(bottomwidget != null) bottomwidget!,
          if(bottomwidget != null) SizedBox(height: 10,),
          Row(children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('cancel'),)),
            ),
             const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(onPressed: (){
                  Navigator.pop(context, setdateTime);
                }, child: Text('confirm'),)),
            )
          ],)

      ],
    );
  }
}


class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({
    Key? key, required this.service,
  }) : super(key: key);

 final AddMedicineService service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      SizedBox(height: 80),
      TextButton(onPressed: service.addNowAlarm,
      child: Center(child:  Text('Add alarm', style: TextStyle(
        color: Colors.black38, fontWeight: FontWeight.w900,) ,),),


       
      
       )
    
    ],);
  }
}