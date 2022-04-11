import 'dart:developer';


import 'package:hive/hive.dart';
import 'package:medicine/models/hiveStorage_medicine_log.dart';

import '../models/hiveStorage_medicine.dart';
import 'hive.dart';



class MedicineLogRepository {
  Box<MedicineLog>? _LogBox;

  Box<MedicineLog> get LogBox {
    _LogBox ??= Hive.box<MedicineLog>( HiveStorageBox.MedicineLog);
    return _LogBox!;
  }



  void addLog(MedicineLog Log) async {
    int key = await LogBox.add(Log);
  }

  void deleteLog(int key) async {
    await LogBox.delete(key);
  }

  void updateLog({
    required int key,
    required MedicineLog Log,
  }) async {
    await LogBox.put(key, Log);

  }


  void deleteAllLog(Iterable<int> keys) async {
    await LogBox.deleteAll(keys);

  } 
  
}