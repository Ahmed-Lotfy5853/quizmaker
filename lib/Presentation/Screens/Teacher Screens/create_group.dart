import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double height (BuildContext context,double height)=> MediaQuery.sizeOf(context).height*height;
  double width (BuildContext context,double width)=> MediaQuery.sizeOf(context).width*width;
  double textFontSize (BuildContext context,double fontSize)=> MediaQuery.textScalerOf(context).scale(fontSize);
File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 243, 243, 1),
      body: Container(
        height: height(context, 1),
        // padding: EdgeInsets.only(bottom:height(context, 0.07)+10),

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        padding:  EdgeInsets.only(left: 15, right: 15 ,top: MediaQuery.paddingOf(context).top),
        child: SingleChildScrollView(
          child: Column(

            children: [
              Image.asset(groupAsset,height: height(context, 0.3),width: width(context, 1),),
              Text(
                "Create new group",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: height(context, 0.05),
              ),
              if(_image != null)
              Container(
                width: width(context,0.25),
                height: width(context,0.25),
                margin: EdgeInsets.only(
                  bottom: height(context, 0.05),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal.shade400,
                  shape: BoxShape.circle
                ),
                child: Image.file(_image!,fit: BoxFit.cover,),

              )
              else
              SizedBox(
                height: height(context, 0.14),
              ),
              Form(
                key: formKey,
                child:                 TextFormField(
                  controller: groupNameController,
                  decoration: const InputDecoration(
                    hintText: 'Group Name',
                    hintStyle: TextStyle(
                      color: Colors.tealAccent,
                    ),
                    prefixIcon: Icon(
                      Icons.group,
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
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),

              ),
              SizedBox(
                height: height(context, 0.14),
              ),
              InkWell(
                child: Container(
                  height: height(context,1/12),
                  width: width(context,0.5),
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Center(
                      child: Text(
                        "Create Group",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: textFontSize(context, 25),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
child: Icon(Icons.camera_alt),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
