import 'package:flutter/material.dart';
import 'package:medicine/pages/mainPage.dart';
import 'package:medicine/repositories/hive.dart';
import 'package:medicine/repositories/medicine_history_repository.dart';
import 'package:medicine/repositories/medicine_repository.dart';
import 'package:medicine/services/notification_service.dart';

final notification=NotificationService();
final hive=  HiveStorage();
final medicineRepository=MedicineRepository();
final historyRepository=MedicineHistoryRepository();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notification = NotificationService();
  await notification.initializeTimeZone();
  await notification.initializeNotification();
  await hive.initializeHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home:  Homepage(),
    );
  }
}


 