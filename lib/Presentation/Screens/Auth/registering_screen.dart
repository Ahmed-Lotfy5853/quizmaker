import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_maker/Bussiness%20Logic/Cubit/Auth/auth_cubit.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/inside_bottom_bar/Home/home.dart';
import '../../../Data/Models/user.dart';
import '../Student Screens/bottom_navigatoion_bar.dart';
import '../Teacher Screens/Home/teacher_home.dart';
import '../Teacher Screens/Home/teacher_nav_bar.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final login_form_key = GlobalKey<FormState>();
  final register_form_key = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'teacher@user.com');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController(text: 'Teacher@1234');
  bool showPassword = true;
  bool isLogin = true;
  bool isTeacher = false;
  String? _selectedAccountType;

  File? _imageFile;

  // Auth_Repository? auth_repository;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<Auth_Cubit>(context).startCubit();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallFontsize = MediaQuery.textScalerOf(context).scale(20);
    double bigFontsize = MediaQuery.textScalerOf(context).scale(25);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyAssets.backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: width / 26,
              right: width / 26,
              top: height / 10.3,
              bottom: height / 16.5),
          child: buildBlocWidget(
              'AuthInitial', height, width, bigFontsize, smallFontsize),
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

  buildLoginForm(
      double height, double width, double bigText, double smallText) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
                height: height / 3.3,
                width: width / 1.3,
                child: Image.asset(
                  MyAssets.loginImage,
                  fit: BoxFit.cover,
                )),
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
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: smallText,
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
                      color: Colors.white,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => showPassword = !showPassword),
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        )),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.white,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  obscureText: showPassword,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: smallText,
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
                    fontSize: smallText,
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
              Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.white, fontSize: smallText - 5),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = false;
                  });
                },
                child: Text(
                  "Register",
                  style:
                      TextStyle(color: Colors.tealAccent, fontSize: smallText),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  buildRegisteringForm(
      double height, double width, double bigText, double smallText) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: width / 6.5,
            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            child: _imageFile == null
                ? Icon(Icons.person, size: width / 7.5, color: Colors.white)
                : null,
          ),
          SizedBox(height: height / 55),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Choose an option"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Take a picture"),
                            onTap: () {
                              Navigator.of(context).pop();
                              _pickImage(ImageSource.camera);
                            },
                          ),
                          SizedBox(height: height / 55),
                          GestureDetector(
                            child: Text("Select from gallery"),
                            onTap: () {
                              Navigator.of(context).pop();
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text(
              "Change Picture",
              style: TextStyle(fontSize: smallText, color: Colors.black),
            ),
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
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                      .toList(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: bigText,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Account Type',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
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
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
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
                    color: Colors.black,
                    fontSize: bigText,
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
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
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
                    color: Colors.black,
                    fontSize: bigText,
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
                      color: Colors.white,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => showPassword = !showPassword),
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        )),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.white,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
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
                    color: Colors.black,
                    fontSize: bigText,
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
                child: Center(
                    child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: bigText,
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
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.white, fontSize: smallText - 5),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = true;
                  });
                },
                child: Text(
                  "Log in",
                  style:
                      TextStyle(color: Colors.tealAccent, fontSize: smallText),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void submitLogin() {
    if (login_form_key.currentState!.validate()) {
      login(_emailController.text.trim(), _passwordController.text.trim(),
              context)
          .then((value) {
        return null;
      });

      /*
      A teacher that has groups created for test
      BlocProvider.of<Auth_Cubit>(context)
          .login("m@gmail.com", "M12345678",
              context)
          .then((value) {
        return null;
      });

       */
      // isTeacher?Navigator.pushNamed(context, teacherHomeScreen):Navigator.pushNamed(context, BottomNavStudentScreen);
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
      signUp(_emailController.text, _passwordController.text, isTeacher,
              _imageFile, _usernameController.text.trim())
          .then((value) {
        return;
      });
    }
  }

  buildBlocWidget(String state, double height, double width, double bigFontsize,
      double smallFontsize) {
    if (state == 'AuthInitial') {
      if (isLogin) {
        return buildLoginForm(height, width, bigFontsize, smallFontsize);
      } else {
        return buildRegisteringForm(height, width, bigFontsize, smallFontsize);
      }
    } else if (state == 'AuthLoading') {
      return showLoadingIndecator();
    } else if (state == 'AuthSuccess') {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context,
            current_user!.isTeacher ? bottomNavStudentScreen : teacherNavBar);
      });
      return Container();
    } else {
      return buildFailedDialog("error");
    }
    ;
  }

  buildFailedDialog(String m) {
    /*
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
    });
     */
    return Center(
      child: Text(m),
    );
  }

  Future<void> signUp(String email, String password, bool isTeacher,
      File? imageFile, String name) async {
    try {
      UserCredential userCredential;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        var img =
            await uploadProfileImage(imageFile, isTeacher, value.user!.uid);
        setFirestoreAccountInfo(isTeacher, img, name, email);

        current_user?.copyWith(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          name: name,
          photoUrl: img,
          isTeacher: isTeacher,
          groups: [],
        );
        return value;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        log('login ${value.user?.uid}');
        getProfile(value.user!.uid, context);
        return value;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setFirestoreAccountInfo(
      bool isTeacher, String? image, String name, String email) async {
    try {
      if (isTeacher) {
        FirebaseFirestore.instance
            .collection(teachersCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "name": name,
          "email": email,
          "cover": image,
          "isTeacher": isTeacher,
        });
      } else {
        FirebaseFirestore.instance
            .collection(studentsCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "name": name,
          "email": email,
          "cover": image,
          "isTeacher": isTeacher,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getProfile(String uId, BuildContext context) async {
    FirebaseFirestore.instance
        .collection(studentsCollection)
        .doc(uId)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          print("student");
          log('student ${data['email']}');

          current_user = UserModel(
            uid: FirebaseAuth.instance.currentUser!.uid,
            email: data['email'],
            name: data['name'],
            photoUrl: data['cover'],
            isTeacher: data['isTeacher'],
            groups: data['groups'] ?? [],
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavBarStudentScreen()));
        } else {
          FirebaseFirestore.instance
              .collection(teachersCollection)
              .doc(uId)
              .get()
              .then(
            (DocumentSnapshot doc) {
              final Map<String, dynamic>? data =
                  doc.data() as Map<String, dynamic>?;
              if (data != null) {
                print("teacher");
                log('teacher ${data['email']}');
                current_user = UserModel(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  email: data['email'],
                  name: data['name'],
                  photoUrl: data['cover'],
                  isTeacher: true,
                  groups: data['groups'] ?? [],
                );

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeacherNavBar()));

                print(current_user!.isTeacher);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('User not found')));
              }
            },
            onError: (e) => print("Error getting document: $e"),
          );
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
    print(current_user!.name);
  }

  Future<String?> uploadProfileImage(
      File? imageFile, bool isTeacher, String imageName) async {
    if (imageFile == null) {
      return null;
    }
    String reference = isTeacher ? 'teachers' : 'students';
    String? downloadURL =
        await uploadImageToFirebaseStorage(imageFile, reference, imageName);

    if (downloadURL != null) {
      return downloadURL;
    } else {
      print('Failed to upload image.');
    }
    return null;
  }

  Future<String?> uploadImageToFirebaseStorage(
      File imageFile, String reference, String imageName) async {
    try {
      // Create a Firebase Storage reference with the specified path and name
      Reference storageReference =
          FirebaseStorage.instance.ref().child(reference).child(imageName);

      // Upload the image file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Wait for the upload to complete
      await uploadTask.whenComplete(() => null);

      // Get the download URL for the image
      String downloadURL = await storageReference.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image to Firebase Storage: $e');
    }
  }
}
