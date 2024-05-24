import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/group.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Groups/create_group.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Home/teacher_home.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Settings/setting.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/chat/teacher_all_chats.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Profile/teacher_profile.dart';

import '../../../../Constants/styles.dart';
import '../All Request/teacher_all_requests.dart';

class TeacherNavBar extends StatefulWidget {
  const TeacherNavBar({super.key});

  @override
  State<TeacherNavBar> createState() => _TeacherNavBarState();
}

class _TeacherNavBarState extends State<TeacherNavBar> {
  var index = 2;

  List<Widget> _screens = [
    TeacherSettingsScreen(),
    TeacherProfile(),
    TeacherHomeScreen(),
    TeacherAllChats(),
    TeacherAllRequestsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    log("current user" + current_user.uid.toString());
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundAsset), fit: BoxFit.cover),
          ),
          child: SafeArea(child: _screens[index])),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Setting',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: 'Chats',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.request_page_outlined,
            ),
            label: 'Requests',
            backgroundColor: Colors.teal,
          ),
        ],
        currentIndex: index,
        onTap: (navIndex) {
          setState(() {
            index = navIndex;
          });
        },
        backgroundColor: Colors.teal,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: nextColor,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: index == 2
          ? FloatingActionButton.extended(
              backgroundColor: Colors.teal,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGroup()),
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'Create Group',
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }
}

/*PersistentTabView(
        context,
        backgroundColor: firstColor,
        controller: _persistentTabController,
        screens: _screens,
        items: _items,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.zero,
        ),
        navBarStyle: NavBarStyle.style15,
      )*/
