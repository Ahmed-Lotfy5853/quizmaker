import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_maker/Data/Models/post_model.dart';

import '../../../Constants/Strings.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key, required this.groupId});
final String? groupId;
  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {

  final postContentController =TextEditingController();

  double height(BuildContext context, double height) =>
      MediaQuery.sizeOf(context).height * height;

  double width(BuildContext context, double width) =>
      MediaQuery.sizeOf(context).width * width;

  double textFontSize(BuildContext context, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize);

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
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    double smallFontsize = MediaQuery.textScalerOf(context).scale(20);
    double bigFontsize = MediaQuery.textScalerOf(context).scale(25);

    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height(context, 0.3),
                  width: width(context, 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                    image:_image == null ? null : DecorationImage(
                        image: FileImage(_image! ) ,
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context, 0.02),
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
                                SizedBox(height: height(context, 1/55)) ,
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
                  height: height(context, 0.02),
                ),
                Container(
                  height: height(context, 1/3),
                  width: width(context, 0.9),
                  child: TextFormField(
                    controller: postContentController,
                    minLines: 5,
                    // Assuming you have a controller named _postContentController
                    decoration: const InputDecoration(
                      hintText: 'Write your post here...', // Updated hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text for your post';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // You can add onChanged logic here if needed
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: bigFontsize,
                    ),
                    maxLines: null, // Allow multiple lines for the post content
                    keyboardType: TextInputType.multiline, // Set keyboard type to multiline
                  ),
                ),

                SizedBox(
                  height: height(context, 0.02),
                ),
                formButton(text: "Post", tap: ()async{
                await  FirebaseStorage.instance.ref().child('posts').child(widget.groupId!).child(DateTime.now().toString()).putFile(_image!).then((p0) {
                    p0.ref.getDownloadURL().then((value) {
                        FirebaseFirestore.instance.collection(groupsCollection).doc(widget.groupId).collection(postsCollection).add(PostModel(content: postContentController.text,teacher: current_user!, image: value,/* teacher: UserModel()*/).toMap()).then((value) {
                          FirebaseFirestore.instance.collection(groupsCollection).doc(widget.groupId).collection(postsCollection).doc(value.id).update({"id" : value.id });
                          Navigator.pop(context);
                        });

                    });
                  });
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formButton({required String text, required void Function() tap}) =>
      GestureDetector(
        onTap: tap,
        child: Container(
          height: height(context, 1 / 12),
          width: width(context, 1 / 2),
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: textFontSize(context, 25),
            ),
          )),
        ),
      );
}
