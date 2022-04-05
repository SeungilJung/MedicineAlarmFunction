import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveImageToLocalDirectory(File image) async {
  final documentDirectory = await getApplicationDocumentsDirectory();
  final folderPath = documentDirectory.path + '/medicien/images';
  final filePath = folderPath + '/${DateTime.now().millisecondsSinceEpoch}.png';

  await Directory(folderPath).create(recursive: true);

  final newFile = File(filePath);
  newFile.writeAsBytesSync(image.readAsBytesSync());

  return filePath;
}
//the code to getting image file path from the image file.
//https://stackoverflow.com/questions/51338041/how-to-save-image-file-in-flutter-file-selected-using-image-picker-plugin