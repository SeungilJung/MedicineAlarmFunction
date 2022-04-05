import 'package:hive_flutter/hive_flutter.dart';
import '../models/hiveStorage_medicine.dart';
import '../models/hiveStorage_medicine_log.dart';


class  HiveStorage {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Medicine>(MedicineAdapter());
    Hive.registerAdapter<MedicineHistory>(MedicineHistoryAdapter());

    await Hive.openBox<Medicine>( HiveStorageBox.medicine);
    await Hive.openBox<MedicineHistory>( HiveStorageBox.medicineHistory);
  }
}

class  HiveStorageBox {
  static const String medicine = 'medicine';
  static const String medicineHistory = 'medicine_history';
}