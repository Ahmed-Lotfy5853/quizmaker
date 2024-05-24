import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Constants/Strings.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isEditing = false;
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(25);
    nameController.text = current_user!.name;
    emailController.text = current_user!.email;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MyAssets.backgroundAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: profileFormKey,
        autovalidateMode: isEditing
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    isEditing
                        ? setState(() {
                            isEditing = false;
                          })
                        : setState(() {
                            isEditing = true;
                            // ToDo add save profile info logic
                          });
                  },
                  child: Text(
                    isEditing ? "Done" : "Edit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: smallerTextFontsize + 5,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: current_user.photoUrl != null
                  ? NetworkImage(current_user.photoUrl!)
                  : Image.asset("assets/images/profile_place_holder.png").image,
            ),
            SizedBox(
              height: 70,
            ),
            SizedBox(
              width: width * 0.80,
              child: TextFormField(
                controller: nameController,
                enabled: isEditing,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: bigTextFontsize,
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
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
                onChanged: (value) {},
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: bigTextFontsize,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: width * 0.80,
              child: TextFormField(
                controller: emailController,
                enabled: isEditing,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: bigTextFontsize,
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
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: bigTextFontsize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
