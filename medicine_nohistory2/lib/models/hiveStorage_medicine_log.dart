import 'package:hive/hive.dart';

part 'hiveStorage_medicine_log.g.dart';

@HiveType(typeId: 2)
class MedicineLog extends HiveObject{
  MedicineLog(   {
    required this.medicineid, 
    required this.alarmTime, 
    required this.takeTime,
    required this.medicineKey,
    required this.name,
    required this.imagePath
    

    
    });
  //id, name, image(optional), alarm

  @HiveField(0,defaultValue: -1)
  final int medicineid;

   @HiveField(1)
  final String alarmTime;

   @HiveField(2)
  final DateTime takeTime;

  @HiveField(3, defaultValue: -1)
  final int medicineKey;

   @HiveField(4, defaultValue: 'Deleted data')
  final String name;

   @HiveField(5)
  final String? imagePath;





   @override
  String toString() {
    // TODO: implement toString
    return '{medicineid: $medicineid, alarmTime: $alarmTime, takeTime: $takeTime, medicineKey:$medicineKey,name:$name, imagePath:$imagePath,}';
  }
}