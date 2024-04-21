import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constants/Strings.dart';
import '../../../Data/Models/group.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  List<Group> groups = [
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 2",
      description: "Group 2 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 3",
      description: "Group 3 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png',
    ),
  ];
  bool isSearching = false;
  List<Group> searchedGroups = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isEditing = false;
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Form(
        key: profileFormKey,
        autovalidateMode: isEditing
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: isEditing ? height / 1.5 : height / 3,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
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
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: Image.asset(
                                    "assets/images/profile_place_holder.png")
                                .image,
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              width: width / 2,
                              child: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                    color: Colors.tealAccent,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
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
                                    return 'Please enter a valid name';
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
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: SizedBox(
                              width: width / 2,
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.tealAccent,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
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
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "My Groups",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              child: ListView.separated(
                padding: EdgeInsets.only(top: 5),
                shrinkWrap: true,
                itemCount: isSearching ? searchedGroups.length : groups.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: Image.asset(isSearching
                              ? searchedGroups[index].image
                              : groups[index].image)
                          .image,
                    ),
                    title: Text(
                      isSearching
                          ? searchedGroups[index].name
                          : groups[index].name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    subtitle: Text(
                      isSearching
                          ? searchedGroups[index].description
                          : groups[index].description,
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, editGroupDetailsScreen,
                            arguments: groups[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.white,
                    thickness: 2,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
