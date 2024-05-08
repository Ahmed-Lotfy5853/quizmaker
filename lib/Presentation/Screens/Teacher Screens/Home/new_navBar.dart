
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/group.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int currentIndex = 0;
  List<Group> groups = [
    Group(
      id: '1',
      name: 'Group 1',
      description: 'Group 1 description',
      image: 'https://picsum.photos/200/300',
      createdAt: "timmeeee", createdBy: 'drrrr'
    ),

  ];
  bool isSearching = false;
  List<Group> searchedGroups = [];
  TextEditingController nameController = TextEditingController();

  bool isEditing = false;
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(15);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    List<Widget> bodyWidgets = [
      buildGroupsScreen(h, w , smallerTextFontsize, bigTextFontsize),
      Icon(Icons.sync_outlined),
      Icon(Icons.chat),
      buildProfileScreen(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      body: SingleChildScrollView(
        child: Center(
          child: bodyWidgets[currentIndex],
        ),
      ),
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            currentIndex: currentIndex,
            onTap: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: "Groups",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sync_outlined),
                label: "Requests",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGroupsScreen(double h, double w , double smallText, double bigText) {
    return Container(
      child: Column(
        children: [
          Container(
            height: h / 3.75 ,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: h/ 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: h /20,
                      child: ClipOval(
                        // Todo add profile picture logic
                        child: Image.asset(
                          // Placeholder image
                          'assets/images/profile_place_holder.png',
                          fit: BoxFit.cover,
                          width: 100,
                          // Adjust width and height as per your requirement
                          height: 100,
                        ),
                      ),
                    ),
                    //Todo add name logic
                    Container(
                      width: w / 2.61,
                      child: Text(
                        "Dr. Mohamed Ahmed Omar Khalil Ibrahim",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: bigText,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, createGroupScreen);
                            },
                            icon: Icon(
                              Icons.add_circle_outlined,
                              color: Colors.green,
                              size: h / 20,
                            )),
                        Text(
                          "Create group",
                          style: TextStyle(color: Colors.green , fontSize: smallText),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: h / 82.5),
                Padding(
                  padding:  EdgeInsets.only(left: w / 26, right: w / 26),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 243, 243, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        hintText: "Search for specific teacher/group",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: smallText,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: smallText,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          isSearching = true;
                          searchedGroups = groups.where((element) {
                            return element.name
                                .toLowerCase()
                                .contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: w / 39.2),
                  child: Text(
                    "My Groups",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: bigText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: h / 1.65,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    itemCount:
                    isSearching ? searchedGroups.length : groups.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          isSearching
                              ? searchedGroups[index].name
                              : groups[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold , fontSize: bigText),
                        ),
                        subtitle: Text(isSearching
                            ? searchedGroups[index].description
                            : groups[index].description , style: TextStyle(fontSize: smallText),),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {},
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
        ],
      ),
    );
  }

  Widget buildProfileScreen() {
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: Form(
        key: profileFormKey,
        autovalidateMode: isEditing? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  isEditing? setState(() {
                    isEditing = false;
                  }): setState(() {
                    isEditing = true;
                    // Todo add save profile info logic
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
            Text(
              "Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage:
              Image.asset("assets/images/profile_place_holder.png").image,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
