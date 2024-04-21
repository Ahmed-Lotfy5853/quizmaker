import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Text('Home Screen'));
  }
}