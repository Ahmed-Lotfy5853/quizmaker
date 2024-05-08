import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quiz_maker/app_router.dart';
import 'Constants/Strings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(Quiz_Maker(app_router: App_Router()));
}

class Quiz_Maker extends StatelessWidget {
  final App_Router app_router;
  const Quiz_Maker({super.key, required this.app_router});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Maker',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: app_router.generateRoute,
      initialRoute: onBoardingScreen,
    );
  }
}
