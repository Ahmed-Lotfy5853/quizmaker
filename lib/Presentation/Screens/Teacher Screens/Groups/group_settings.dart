import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';

import '../../../../Data/Models/group.dart';
import '../edit_group_details.dart';

class GroupSettings extends StatefulWidget {
  GroupSettings({super.key, required this.group});
final Group group;
  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    //Group? widget.group = ModalRoute.of(context)!.settings.arguments as Group;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          widget.group.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    widget.group.description!,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                buildButton("Questions Bank", Icons.account_balance_sharp,
                    height, width, smallerTextFontsize, () {
                  Navigator.pushNamed(context, questionsBankScreen,arguments: widget.group.id);
                }),
                SizedBox(
                  height: 40,
                ),

                buildButton("Edit Group", Icons.edit, height, width,
                    smallerTextFontsize, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditGroupDetails(groupId: widget.group.id!,)));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String title, IconData icon, double height, double width,
      double smallerTextFontsize, Function onTap) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: height / 12,
          width: width / 1.5,
          decoration: BoxDecoration(
            color: Colors.green[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: smallerTextFontsize,
                ),
              ),
              Icon(icon),
            ],
          )),
        ),
      ),
    );
  }
}
