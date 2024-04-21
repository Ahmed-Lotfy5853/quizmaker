import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Web%20Services/Auth/auth_webservices.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/GroupDetails/Quize/quize.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/GroupDetails/group_details.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/bottom_navigatoion_bar.dart';
import 'package:quiz_maker/Presentation/Screens/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bussiness Logic/Cubit/Auth/auth_cubit.dart';
import 'Data/Repository/Auth/auth_repository.dart';
import 'Presentation/Screens/Auth/registering_screen.dart';
import 'Presentation/Screens/Teacher Screens/create_group.dart';
import 'Presentation/Screens/Teacher Screens/edit_group_details.dart';
import 'Presentation/Screens/Teacher Screens/teacher_homepage.dart';

class App_Router {
  late final Auth_Cubit authCubit;

  App_Router() {
    Auth_Repository auth_Repository = Auth_Repository(Auth_WebServices());
    authCubit = Auth_Cubit(auth_Repository);
  }

  Route? generateRoute(RouteSettings settings) {
    FlutterNativeSplash.remove();
    switch (settings.name) {
      case (onBoardingScreen):
        return MaterialPageRoute(builder: (_) => const OnBoarding_Screen());
      case (registerScreen):
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => authCubit,
                  child: const Register_Screen(),
                ));
      case (BottomNavStudentScreen):
        return MaterialPageRoute(builder: (_) => BottomNavBarStudentScreen());
      case (teacherHomeScreen):
        return MaterialPageRoute(builder: (_) => const TeacherHomePage());
      case (createGroupScreen):
        return MaterialPageRoute(builder: (_) => const CreateGroup());
      case (studentGroupDetailScreen):
        return MaterialPageRoute(builder: (_) => StudentGroupDetails());
      case (quizeScreen):
        return MaterialPageRoute(builder: (_) => const QuizeView());
      case (editGroupDetailsScreen):
        return MaterialPageRoute(builder: (_) => const EditGroupDetails());
      case (questionsBankScreen):
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Text("Page Not Found"),
                  ),
                ));
    }
  }
}
