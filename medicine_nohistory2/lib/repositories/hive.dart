import 'package:hive_flutter/hive_flutter.dart';
import '../models/hiveStorage_medicine.dart';
import '../models/hiveStorage_medicine_log.dart';


class  HiveStorage {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());
    Hive.registerAdapter<MedicineLog>(MedicineLogAdapter());

    await Hive.openBox<Medicine>( HiveStorageBox.medicine);
    await Hive.openBox<MedicineLog>( HiveStorageBox.MedicineLog);
  }
}

class  HiveStorageBox {
  static const String medicine = 'medicine';
  static const String MedicineLog = 'medicine_Log';
}