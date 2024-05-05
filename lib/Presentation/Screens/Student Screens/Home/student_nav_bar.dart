import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/styles.dart';
import '../../../../../Constants/Strings.dart';
import '../../Teacher Screens/Profile/teacher_profile.dart';
import '../All Request/student_all_requests.dart';
import '../Settings/setting.dart';
import 'student_home.dart';
import '../chat/student_all_chats.dart';

class BottomNavBarStudentScreen extends StatefulWidget {
  BottomNavBarStudentScreen({super.key});

  @override
  State<BottomNavBarStudentScreen> createState() =>
      _BottomNavBarStudentScreenState();
}

class _BottomNavBarStudentScreenState extends State<BottomNavBarStudentScreen> {
  List<Widget> _screens = [
    StudentSettingsScreen(),
    TeacherProfile(),
    StudentHomeScreen(),
    StudentAllChats(),
    StudentAllRequestsPage(),
  ];

  int index = 2;

  @override
  Widget build(BuildContext context) {
    print("Iam a Student");
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}
