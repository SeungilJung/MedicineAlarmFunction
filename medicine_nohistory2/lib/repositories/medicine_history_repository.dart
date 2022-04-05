import 'dart:developer';


import 'package:hive/hive.dart';
import 'package:medicine/models/hiveStorage_medicine_log.dart';

import '../models/hiveStorage_medicine.dart';
import 'hive.dart';



class MedicineHistoryRepository {
  Box<MedicineHistory>? _historyBox;

  Box<MedicineHistory> get historyBox {
    _historyBox ??= Hive.box<MedicineHistory>( HiveStorageBox.medicineHistory);
    return _historyBox!;
  }



  void addHistory(MedicineHistory history) async {
    int key = await historyBox.add(history);
  }

  void deleteHistory(int key) async {
    await historyBox.delete(key);
  }

  void updateHistory({
    required int key,
    required MedicineHistory history,
  }) async {
    await historyBox.put(key, history);

  }


  void deleteAllHistory(Iterable<int> keys) async {
    await historyBox.deleteAll(keys);

  } 
  
}