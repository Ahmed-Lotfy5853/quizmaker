import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditGroupDetails extends StatefulWidget {
  const EditGroupDetails({super.key});

  @override
  State<EditGroupDetails> createState() => _EditGroupDetailsState();
}

class _EditGroupDetailsState extends State<EditGroupDetails> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(25);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: height / 13.75),
        color: Color.fromRGBO(244, 243, 243, 1),
        child: ListView(
          children: [
            Text(
              "Edit Group Details",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: bigTextFontsize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: height / 55,
            ),
            CircleAvatar(
              radius: height / 16.5,
              backgroundImage:
                  Image.asset("assets/images/profile_place_holder.png").image,
            ),
            SizedBox(
              height: 825 / 41.25,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 26),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter group name',
                        hintStyle: TextStyle(
                          color: Colors.tealAccent,
                        ),
                        prefixIcon: Icon(
                          Icons.groups_outlined,
                          color: Colors.tealAccent,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Please enter a valid group name';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: smallerTextFontsize,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 26),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter group description',
                        hintStyle: TextStyle(
                          color: Colors.tealAccent,
                        ),
                        prefixIcon: Icon(
                          Icons.groups_outlined,
                          color: Colors.tealAccent,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Please enter a valid group description';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: smallerTextFontsize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  editGroup();
                },
                child: Container(
                  height: height / 12,
                  width: width / 2,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: smallerTextFontsize,
                    ),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: height / 27.5,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDeleteDialog(
                      height, width, smallerTextFontsize, bigTextFontsize);
                },
                child: Container(
                  height: height / 12,
                  width: width / 2,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Delete Group",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: smallerTextFontsize,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editGroup() {
    if (formKey.currentState!.validate()) {
      print(nameController.text);
      //ToDo edit group logic
    }
  }

  void showDeleteDialog(double h, double w, double fontSize, double bigfont) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Are you sure?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: bigfont,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: h / 13.75,
                          width: w / 4,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w / 13,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          //ToDo delete group logic
                        },
                        child: Container(
                          height: h / 13.75,
                          width: w / 4,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "yes",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
