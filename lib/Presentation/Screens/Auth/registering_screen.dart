import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_maker/Bussiness%20Logic/Cubit/Auth/auth_cubit.dart';
import 'package:quiz_maker/Constants/Strings.dart';

import '../posts/post_create.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final login_form_key = GlobalKey<FormState>();
  final register_form_key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = true;
  bool isLogin = true;
  bool isTeacher = false;
  String? _selectedAccountType;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textFontsize = MediaQuery.textScalerOf(context).scale(25);
    print(height);
    print(width);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: width / 26,
              right: width / 26,
              top: height / 10.3,
              bottom: height / 16.5),
          child: isLogin
              ? buildLoginForm(height, width, textFontsize)
              : buildRegisteringForm(height, width, textFontsize),
        ),
      ),
    );
  }

  Widget showLoadingIndecator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  bool containsLetterAndNumber(String value) {
    return RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(value);
  }

  buildLoginForm(double height, double width, double text) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
                height: height / 3.3,
                width: width / 1.3,
                child: Image.asset(
                  "assets/images/quizregister.png",
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: height / 27.5,
          ),
          Text(
            "Log in",
            style: TextStyle(fontSize: text, color: Colors.white),
          ),
          SizedBox(
            height: height / 41.25,
          ),
          Form(
            key: login_form_key,
            child: Column(
              children: [
                //email field

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.tealAccent,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
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
                SizedBox(
                  height: height / 41.25,
                ),
                // password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: Colors.tealAccent,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => showPassword = !showPassword),
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.tealAccent,
                        )),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.tealAccent,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.tealAccent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.tealAccent,
                      ),
                    ),
                  ),
                  obscureText: showPassword,
                  validator: (value) {
                    if (value == null ||
                        value.length < 8 ||
                        !containsLetterAndNumber(value)) {
                      return 'Password must be at least 8 characters\nlong and contain both letters and numbers';
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
              ],
            ),
          ),
          SizedBox(
            height: height / 41.25,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                submitLogin();
              },
              child: Container(
                height: height / 12,
                width: width / 2,
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: text,
                  ),
                )),
              ),
            ),
          ),
          SizedBox(
            height: height / 41.25,
          ),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = false;
                  });
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.tealAccent, fontSize: 18),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  buildRegisteringForm(double height, double width, double text) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
                height: height / 3.3,
                width: width / 1.3,
                child: Image.asset(
                  "assets/images/quizregister.png",
                  fit: BoxFit.contain,
                )),
          ),
          SizedBox(
            height: height / 41.25,
          ),
          Text(
            "Register",
            style: TextStyle(fontSize: text, color: Colors.white),
          ),
          SizedBox(
            height: height / 41.25,
          ),
          Form(
            key: register_form_key,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedAccountType,
                  onChanged: (value) {
                    setState(() {
                      if (value == 'Teacher') {
                        isTeacher = true;
                      } else {
                        isTeacher = false;
                      }
                      _selectedAccountType = value!;
                    });
                  },
                  items: ['Teacher', 'Student']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: TextStyle(
                                  color: _selectedAccountType == type
                                      ? Colors.tealAccent
                                      : Colors.black),
                            ),
                          ))
                      .toList(),
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: text,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Account Type',
                    hintStyle: TextStyle(
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
                ),

                SizedBox(
                  height: height / 41.25,
                ),
                // username field
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.tealAccent,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
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
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Username must be at least 4 characters long';
                    }
                    if (_selectedAccountType == null) {
                      return 'please select an account type';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text,
                  ),
                ),
                SizedBox(
                  height: height / 41.25,
                ),
                //email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.tealAccent,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text,
                  ),
                ),
                SizedBox(
                  height: height / 41.25,
                ),
                // password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: Colors.tealAccent,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => showPassword = !showPassword),
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.tealAccent,
                        )),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.tealAccent,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.tealAccent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.tealAccent,
                      ),
                    ),
                  ),
                  obscureText: showPassword,
                  validator: (value) {
                    if (value == null ||
                        value.length < 8 ||
                        !containsLetterAndNumber(value)) {
                      return 'Password must be at least 8 characters\nlong and contains both letters and numbers';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 41.25,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                submitRegister();
              },
              child: Container(
                height: height / 12,
                width: width / 2,
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Already have an account?",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = true;
                  });
                },
                child: const Text(
                  "Log in",
                  style: TextStyle(color: Colors.tealAccent, fontSize: 18),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  buildDialog() {
    return AlertDialog(
      title: const Text(
        "Are you a student or teacher?",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Student",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Teacher",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ],
        )
      ],
    );
  }

  void submitLogin() {
    Navigator.pushNamed(context, BottomNavStudentScreen);
    if (login_form_key.currentState!.validate()) {
      //   isTeacher?Navigator.pushNamed(context, teacherHomeScreen):Navigator.pushNamed(context, BottomNavStudentScreen);
// Navigator.push(context, MaterialPageRoute(builder: (context)=>
// PostCreate()
      /*   Scaffold(
  // body: TeacherAllRequestsPage(),
  body: TeacherAllChats(),
)*/
//))  ;
      /* BlocProvider.of<Auth_Cubit>(context)
          .login(_emailController.text, _passwordController.text);*/
    }
  }

  void submitRegister() {
    if (register_form_key.currentState!.validate()) {
      /*
      BlocProvider.of<Auth_Cubit>(context)
          .signUp(_emailController.text, _passwordController.text, isTeacher);

       */
      isTeacher
          ? Navigator.pushNamed(context, teacherHomeScreen)
          : Navigator.pushNamed(context, BottomNavStudentScreen);
    }
  }
}
