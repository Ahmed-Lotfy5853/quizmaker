import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/group.dart';

import '../../../../Bussiness Logic/Cubit/groups/group_cubit.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallFontsize = MediaQuery.textScalerOf(context).scale(20);
    double bigFontsize = MediaQuery.textScalerOf(context).scale(25);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundAsset),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Create new group",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CircleAvatar(
                  radius: width / 6.5,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  backgroundColor: _image == null
                      ?Colors.teal:Colors.transparent,
                  child: _image == null
                      ? Icon(Icons.groups, size: width / 7.5, color: Colors.white)
                      : null,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Choose an option"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text("Take a picture"),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _pickImage(ImageSource.camera);
                                  },
                                ),
                                SizedBox(height: height / 55),
                                GestureDetector(
                                  child: Text("Select from gallery"),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _pickImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "Change Picture",
                    style:
                        TextStyle(fontSize: smallFontsize, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Group Name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.groups,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Group name must be at least 4 characters long';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: smallFontsize,
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                TextFormField(
                  controller: groupNameController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Username must be at least 4 characters long';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: smallFontsize,
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    createGroup();
                  },
                  child: Container(
                    height: height * 0.083,
                    width: width / 2,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      "Create Group",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: smallFontsize,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createGroup() async{
    if (formKey.currentState!.validate()) {
      Group group = Group(
        name: groupNameController.text,
        image: "",
        description: descriptionController.text,
        createdBy: current_user!.name,
        createdAt: DateTime.now().toString(),
      );


      await  FirebaseStorage.instance.ref().child('groups').child(groupNameController.text).child(DateTime.now().toString()).putFile(_image!).then((p0) {
        p0.ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance.collection(groupsCollection).add(Group(
            name: descriptionController.text,
            image: value,
            description: groupNameController.text,
            createdBy: current_user!.name,
            createdAt: DateTime.now().toString(),
            teachers: [current_user!.uid!],
          ).toMap()).then((value) {
            current_user?.groups?.add(value.id);
            log("groups ${current_user?.groups}");
            FirebaseFirestore.instance.collection(teachersCollection).doc(current_user!.uid).update({"groups" : current_user?.groups });
            FirebaseFirestore.instance.collection(groupsCollection).doc(value.id).update({"id" : value.id });
            Navigator.pop(context);
          });

        });
      });

    }
  }
}
