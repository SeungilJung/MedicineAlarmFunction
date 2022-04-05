import 'package:flutter/material.dart';
 


class BasicPageBodyFormet extends StatelessWidget {
  const BasicPageBodyFormet({ Key? key, required this.children }) : super(key: key);
  final List<Widget> children;

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
         FocusScope.of(context).unfocus(); 
        }, 
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
    ),),);
  }
}