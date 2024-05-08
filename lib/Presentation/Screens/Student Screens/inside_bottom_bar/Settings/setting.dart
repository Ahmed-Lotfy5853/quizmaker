import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Presentation/Screens/Auth/registering_screen.dart';

import '../../../../../Bussiness Logic/Cubit/Auth/auth_cubit.dart';


class StudentSettingsScreen extends StatelessWidget {
  StudentSettingsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context) .scale(20)  ;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundAsset), fit: BoxFit.cover),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildButton("Logout", Icons.logout, height, width, smallerTextFontsize, () {
                logout(context) ;
                // ToDo navigator not working
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register_Screen()));
              }),
              SizedBox(height: 40),
              buildButton("Delete Account", Icons.delete, height, width, smallerTextFontsize, () {
                deleteAccount(context);
                Navigator.pushNamed(context, registerScreen);
              }),

            ]
        ),
      ),
    );
  }

  Widget buildButton(String title, IconData icon, double height, double width,
      double smallerTextFontsize, Function onTap) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onTap();

        },
        child: Container(
          height: height / 12,
          width: width / 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: smallerTextFontsize,
                    ),
                  ),
                  Icon(icon , size: 30,),
                ],
              )),
        ),
      ),
    );
  }

  void logout(BuildContext context) {
   signOut();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteAccount(BuildContext context) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
