import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({ Key? key, required this.children }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: children
                              
                            ),
                            ),
                            );
  }
}


void showPermissionDenied(BuildContext context, {required String permission}){ 
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                      Text('$permission  no permission.'),
                      TextButton(onPressed: openAppSettings,                      
                      child: Text("Option"),)
                    ],)), );
}