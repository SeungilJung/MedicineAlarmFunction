

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AddMedicineService with ChangeNotifier{
final alarms=<String>{
  '09:00'
};

Set<String> get Alarms => alarms;

 void addNowAlarm(){
    final now= DateTime.now();
    alarms.add('${now.hour}:${now.minute}');   
    notifyListeners();   
 } 


 void setAlarm({required String prevTime,required DateTime setTime}){
     alarms.remove(prevTime);        
     final setTimeStr = DateFormat('HH:mm').format(setTime);
     alarms.add(setTimeStr);   
      notifyListeners();
 }


  void remomeAlarm(alarmTime){
     alarms.remove(alarmTime);   
      notifyListeners();
 }
}