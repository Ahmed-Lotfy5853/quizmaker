import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/inside_bottom_bar/All%20Request/student_all_requests.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/inside_bottom_bar/Home/home.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/inside_bottom_bar/Profile/profile.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/inside_bottom_bar/Settings/setting.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/inside_bottom_bar/chat/student_all_chats.dart';

class BottomNavBarStudentScreen extends StatefulWidget {
  BottomNavBarStudentScreen({super.key});

  @override
  State<BottomNavBarStudentScreen> createState() =>
      _BottomNavBarStudentScreenState();
}

class _BottomNavBarStudentScreenState extends State<BottomNavBarStudentScreen> {
  int currentItem = 2;
  List<Widget> _screens = [
    SettingScreen(),
    ProfileScreen(),
    HomeScreen(),
    StudentAllChats(),
    StudentAllRequestsPage(),
  ];

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Setting',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.chat,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.request_page_outlined,
      ),
      label: 'All Request',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[currentItem],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: nextColor,
          ),
          label: Text(
            'Add',
            style: TextStyle(color: nextColor),
          ),
          backgroundColor: firstColor,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: firstColor,
            primaryColor: nextColor,
          ),
          child: BottomNavigationBar(
            backgroundColor: nextColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: _items,
            currentIndex: currentItem,
            onTap: (value) {
              setState(() {
                currentItem = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
