


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../../models/object_medicine_alarm.dart';
import '../../models/hiveStorage_medicine_log.dart';
import '../bottomsheet/time_bottomsheet.dart';


class BeforeTile extends StatelessWidget {
  const BeforeTile({
    Key? key,
     required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;


  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        MedicinePhoto(imagePath: medicineAlarm.imagePath,),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(textStyle, context),
          ),
        ),
        DeleteDataButton(medicineAlarm: medicineAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    return [
            Text('🕑${medicineAlarm.alarmTime}', style: textStyle),
            const SizedBox(height: 6),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('${medicineAlarm.name},', style: textStyle),
                TileActionButton(     
                  onTap: () => _onPreviousTake(context),
                  title: 'Taken',
                ),
                Text('Taken Well!', style: textStyle),
              ],
            )
          ];
  }


 void _onPreviousTake (BuildContext context) {
                    showModalBottomSheet(context: context, builder: (context) => TimeSettingBottomSheet(initialTime:medicineAlarm.alarmTime )
                     ).then((takeDateTime) {
                       if(takeDateTime==null||takeDateTime is !DateTime){
                         return;
                       }
                       historyRepository.addHistory(MedicineHistory(
                         medicineid: medicineAlarm.id, 
                         alarmTime: medicineAlarm.alarmTime, 
                         takeTime: takeDateTime, 
                         medicineKey: medicineAlarm.key,
                         imagePath: medicineAlarm.imagePath, 
                         name: medicineAlarm.name));
                     });
                  }
}




class AfterTile extends StatelessWidget {
  const AfterTile({
    Key? key,
     required this.medicineAlarm, required this.history,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;
  final MedicineHistory history;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        Stack(
          children: [
            MedicinePhoto(imagePath: medicineAlarm.imagePath),
            CircleAvatar(
              radius:40,
              backgroundColor: Colors.green.withOpacity(0.6),
              child: Icon(
                CupertinoIcons.check_mark,
                color: Colors.white,
              )
              
            )
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(textStyle, context),
          ),
        ),
        DeleteDataButton(medicineAlarm: medicineAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context) {
    DateFormat("HH:mm").format(history.takeTime);
    return [
        Text.rich(
        TextSpan(
          text: '✅ ${medicineAlarm.alarmTime} → ',
          style: textStyle, 
          children: [
            TextSpan(
              text: takeTimeStr,
              style: textStyle?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
            
            
            
            const SizedBox(height: 6),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('${medicineAlarm.name},', style: textStyle),
                TileActionButton(
                  onTap: () => _onTap(context),
                  title:  DateFormat(" At HH  mm     ").format(history.takeTime),
                ),
                Text('|', style: textStyle),
                Text('Taken well!', style: textStyle),
              ],
            )
          
            
          ];
          
  }

  String get takeTimeStr => DateFormat("HH:mm").format(history.takeTime);

  void _onTap (BuildContext context) {
                    showModalBottomSheet(context: context, builder: (context) => TimeSettingBottomSheet(
                      initialTime:takeTimeStr,
                      bottomwidget: TextButton( onPressed: () { 
                       historyRepository.deleteHistory(history.key);
                        Navigator.pop(context);
                       },
                      child: Text('Erase the time'),),)
                     ).then((takeDateTime) {
                       if(takeDateTime==null||takeDateTime is !DateTime){
                         return;
                       }
                       historyRepository.updateHistory(
                         
                         key: history.key,
                         history:MedicineHistory(
                         medicineid: medicineAlarm.id, 
                         alarmTime: medicineAlarm.alarmTime, 
                         takeTime: takeDateTime, 
                         medicineKey: medicineAlarm.key,
                         imagePath: medicineAlarm.imagePath, 
                         name: medicineAlarm.name), );
                     });

  }
}





class DeleteDataButton extends StatelessWidget {
  const DeleteDataButton({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        
        notification.deleteMultipleAlarm(alarmIds);
        historyRepository.deleteAllHistory(keys);
        medicineRepository.deleteMedicine(medicineAlarm.key);
        //Navigator.pop(context);
      },
      child: const Icon(CupertinoIcons.bin_xmark),
    );
  }

   List<String> get alarmIds {
    final medicine = medicineRepository.medicineBox.values
        .singleWhere((element) => element.id == medicineAlarm.id);
    final alarmIds = medicine.alarms
        .map((alarmStr) => notification.alarmId(medicineAlarm.id, alarmStr))
        .toList();
    return alarmIds;
  }

  Iterable<int> get keys {
    final histories = historyRepository.historyBox.values.where((histroy) =>
        histroy.medicineid == medicineAlarm.id &&
        histroy.medicineKey == medicineAlarm.key);
    final keys = histories.map((e) => e.key as int);
    return keys;
  }
}




class MedicinePhoto extends StatelessWidget {
  const MedicinePhoto({
    Key? key,
    required this.imagePath
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return   CircleAvatar(
        radius: 40,
        foregroundImage:imagePath ==null? null: FileImage(File(imagePath!)),
      
    );
  }
}






class TileActionButton extends StatelessWidget {
  const TileActionButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.w500);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}