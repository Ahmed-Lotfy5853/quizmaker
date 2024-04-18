import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/All%20Request/student_all_requests.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/Home/home.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/Profile/profile.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/Settings/setting.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/chat/student_all_chats.dart';

class BottomNavBarStudentScreen extends StatelessWidget {
  BottomNavBarStudentScreen({super.key});
  PersistentTabController _persistentTabController =
      PersistentTabController(initialIndex: 0);
  List<Widget> _screens = [
    SettingScreen(),
    ProfileScreen(),
    HomeScreen(),
    StudentAllChats(),
    StudentAllRequestsPage(),
  ];
  List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.settings,
      ),
      title: 'Setting',
      activeColorSecondary: nextColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.person,
      ),
      title: 'Profile',
      activeColorSecondary: nextColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.home,
        color: nextColor,
      ),
      title: 'Home',
      textStyle: TextStyle(color: nextColor),
      activeColorPrimary: firstColor,
      activeColorSecondary: nextColor,
      inactiveColorPrimary: Colors.grey,
      inactiveIcon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.chat,
      ),
      title: 'Chats',
      activeColorSecondary: nextColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.request_page_outlined,
      ),
      title: 'All Request',
      activeColorSecondary: nextColor,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.add,color: nextColor,),
            label: Text('Add',style: TextStyle(color: nextColor),),
            backgroundColor: firstColor,
          ),
          context,
          backgroundColor: firstColor,
          controller: _persistentTabController,
          screens: _screens,
          items: _items,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.zero,
          ),
          navBarStyle: NavBarStyle.style15,
        ),
      ),
    );
  }
}
