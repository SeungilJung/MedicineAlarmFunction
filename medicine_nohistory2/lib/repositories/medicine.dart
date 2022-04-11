import 'package:hive/hive.dart';
import '../models/hiveStorage_medicine.dart';
import 'hive.dart';



class MedicineRepository {
  Box<Medicine>? _medicineBox;

  Box<Medicine> get medicineBox {
    _medicineBox ??= Hive.box<Medicine>( HiveStorageBox.medicine);
    return _medicineBox!;
  }

  void addMedicine(Medicine medicine) async {
    int key = await medicineBox.add(medicine);
  }

  void deleteMedicine(int key) async {
    await medicineBox.delete(key);
  }

  void updateMedicine({
    required int key,
    required Medicine medicine,
  }) async {
    await medicineBox.put(key, medicine);
  }

  int get newId {
    final lastId = medicineBox.values.isEmpty ? 0 : medicineBox.values.last.id;
    return lastId + 1;
  }
}