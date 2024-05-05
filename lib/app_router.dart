import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/group.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Groups/view_quiz.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Home/new_navBar.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Home/teacher_nav_bar.dart';
import 'package:quiz_maker/Presentation/Screens/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bussiness Logic/Cubit/Auth/auth_cubit.dart';
import 'Data/Models/exam_model.dart';
import 'Data/Models/user.dart';
import 'Data/Repository/Auth/auth_repository.dart';
import 'Presentation/Screens/Auth/registering_screen.dart';
import 'Presentation/Screens/Student Screens/GroupDetails/student_group_details.dart';
import 'Presentation/Screens/Teacher Screens/Groups/create_group.dart';
import 'Presentation/Screens/Teacher Screens/Groups/teacher_group_details.dart';
import 'Presentation/Screens/Teacher Screens/Home/teacher_home.dart';
import 'Presentation/Screens/Teacher Screens/questions bank/add_questions.dart';
import 'Presentation/Screens/Teacher Screens/questions bank/create_quiz.dart';
import 'Presentation/Screens/Teacher Screens/Profile/teacher_profile.dart';
import 'Presentation/Screens/Teacher Screens/questions bank/questions_bank.dart';

class App_Router {
  Route? generateRoute(RouteSettings settings) {
    FlutterNativeSplash.remove();
    switch (settings.name) {
      case (onBoardingScreen):
        return MaterialPageRoute(builder: (_) => const OnBoarding_Screen());
      case (registerScreen):
        return MaterialPageRoute(builder: (_) => Register_Screen());

      case (teacherNavBar):
        return MaterialPageRoute(builder: (_) => TeacherNavBar());
      case (addQuestions):
        return MaterialPageRoute(builder: (_) => Add_Questions());

/*      case (createQuizScreen):
        return MaterialPageRoute(builder: (_) => Create_Quiz());*/

      case questionsBankScreen:
        return MaterialPageRoute(
            builder: (_) => Questions_Bank(
                  groupId: settings.arguments as String,
                ));

      case (teacherProfileScreen):
        return MaterialPageRoute(builder: (_) => TeacherProfile());

      case (teacherViewQuizScreen):
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ViewQuiz(
                  exam: args['exam'] as ExamModel,
                  group: args['group'] as Group,
                  currentUser: args['currentUser'] as UserModel,
                  teachers: args['teachers'] as List<UserModel>,
                  students: args['students'] as List<UserModel>,
                ));
    }
  }
}
