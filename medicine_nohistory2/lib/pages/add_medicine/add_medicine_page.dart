//import 'dart:ffi';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:medicine/pages/bottomsheet/bottomsheet+permission.dart';
import 'package:medicine/pages/add_medicine/add_alarm_page.dart';

import 'components/BasicPageBodyFormet.dart';

class AddMedicinePage extends StatefulWidget {
  AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _nameController = TextEditingController();
  File? _medicineImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: CloseButton(),
      ),
      body: SingleChildScrollView(
        child: BasicPageBodyFormet(
          children: [
            Text("Which medicine is it?",
                style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 40),
            Center(
              child: MedicineIconButton(
                changeImageFile: (File? value) {
                  _medicineImage = value;
                },
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Medicine name',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextFormField(
              controller: _nameController,
              maxLength: 20,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                hintText: 'write down the name of the medicine.',
                hintStyle: Theme.of(context).textTheme.bodyText2,
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.subtitle1,
                ),
                onPressed: _nameController.text.isEmpty ? null : addingAlarm,
                child: Text('Next')),
          ),
        ),
      ),
    );
  }

  void addingAlarm() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAlarmPage(
                medicineImage: _medicineImage,
                medicineName: _nameController.text)));
  }
}

class MedicineIconButton extends StatefulWidget {
  const MedicineIconButton({Key? key, required this.changeImageFile})
      : super(key: key);
  final ValueChanged<File?> changeImageFile;
  @override
  State<MedicineIconButton> createState() => _MedicineIconButtonState();
}





class _MedicineIconButtonState extends State<MedicineIconButton> {
  File? _medicineImage;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        padding: _medicineImage == null ? null : EdgeInsets.zero,
        onPressed: _showBottomSheet,
        child: _medicineImage == null
            ? Icon(CupertinoIcons.photo_camera_solid,
                size: 30, color: Colors.white)
            : CircleAvatar(
                foregroundImage: FileImage(_medicineImage!),
                radius: 40,
              ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheet(
            onPressedCamera: () => _onPressed(ImageSource.camera), //이미지 피커의 이미지 소스 
            onPressedGallery: () => _onPressed(ImageSource.gallery),
          );
        });
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((a) {// 이미지 피커 파일 소스 불러오기
      if (a == null) return; //exception 할당하기
      setState(() {
        _medicineImage = File(a.path);
        widget.changeImageFile(_medicineImage);
        Navigator.maybePop(context);
      });
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);

  final VoidCallback? onPressedCamera;
  final VoidCallback? onPressedGallery;
  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(onPressed: onPressedCamera, child: Text('Camera')),
        TextButton(onPressed: onPressedGallery,child: Text('Photo'),
        ),
      ],
    );
  }
}
