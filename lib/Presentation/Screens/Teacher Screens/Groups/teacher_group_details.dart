import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/responsive.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Groups/group_settings.dart';
import '../../../../Constants/styles.dart';
import '../../../../Data/Models/comment_model.dart';
import '../../../../Data/Models/exam_model.dart';
import '../../../../Data/Models/group.dart';
import '../../../../Data/Models/post_model.dart';
import '../../../../Data/Models/user.dart';
import '../../group_info_screen.dart';
import '../posts/post_create.dart';
import '../questions bank/create_quiz.dart';

class TeacherGroupDetails extends StatefulWidget {
  TeacherGroupDetails({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  State<TeacherGroupDetails> createState() => _TeacherGroupDetailsState();
}

class _TeacherGroupDetailsState extends State<TeacherGroupDetails> {
  // String groupName;
  TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<CommentModel> comments = [];

  getAllPosts() async {
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(postsCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          for (var element in value.docs) {
            log(element["id"]);
            posts.add(PostModel.fromMap(element.data()));
            log(posts.first.id.toString());
          }
        });
      }
    });
  }

  getAllQuizzes() async {
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(quizCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          for (var element in value.docs) {
            exams.add(ExamModel.fromMap(element.data()));
          }
        });
      }
    });
  }

  Future<List<UserModel>> getTeachers(List<String> teacherIds) async {
    print("teacherIds ${teacherIds.length}");
    await FirebaseFirestore.instance
        .collection(teachersCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (teacherIds.contains(element.id)) {
            teachers.add(UserModel.fromMap(element.data()));
          }
        }
        return teachers;
      }
    });
    teachers.forEach((element) {
      print(element.name);
      print(element.uid);
    });
    return teachers;
  }

  Future<List<UserModel>> getStudents(List<String> studentIds) async {
    print("studentIds ${studentIds.length}");
    await FirebaseFirestore.instance
        .collection(studentsCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (studentIds.contains(element.id)) {
            students.add(UserModel.fromMap(element.data()));
          }
        }
        return students;
      }
    });
    return students;
  }

  List<PostModel> posts = [];
  List<ExamModel> exams = [];
  List<UserModel> teachers = [];
  List<UserModel> students = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: firstColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.group.name,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () async {
                  List<UserModel> teachersMembers = await getMembers(members: widget.group.teachers??[], type: teachersCollection);
                  List<UserModel> studentsMembers = await getMembers(members: widget.group.students??[], type: studentsCollection);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>GroupInfoScreen(groupName: widget.group.name, teachers: teachersMembers, students:studentsMembers,)));
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                )
              ),
            )
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          children: [
            SpeedDialChild(
                child: Icon(Icons.edit),
                label: 'Create post',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PostCreate(
                              groupId: widget.group.id,
                            )),
                  );
                }),
            SpeedDialChild(
              child: Icon(Icons.lightbulb_outline),
              label: 'Create a quiz',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Create_Quiz(
                            groupId: widget.group.id!,
                          )),
                );
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.settings),
                label: 'Group Settings',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => GroupSettings(
                                group: widget.group,
                              )));
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // for quiz
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: exams.length,
                itemBuilder: (context, int index) => InkWell(
                  onTap: () {
                    log(exams[index].name);
                    log((exams[index].results?.length ?? 0).toString());
                    Navigator.of(context).pushNamed(
                      teacherViewQuizScreen,
                      arguments: {
                        'exam': exams[index],
                        'group': widget.group,
                        'currentUser': current_user,
                        'teachers': teachers,
                        'students': students,
                      },
                    );
                  },
                  child: Card(
                    child: Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        title: Text(
                          exams[index].name,
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          "from " +
                              formatDateString(exams[index].startAt!) +
                              " to " +
                              formatDateString(exams[index].endAt!),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // for post
              ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, int index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: posts[index].teacher?.photoUrl !=
                                      null
                                  ? NetworkImage(
                                      posts[index].teacher!.photoUrl!)
                                  : AssetImage(profileAsset) as ImageProvider,
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(posts[index].teacher!.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        if (posts[index].image != null)
                          Container(
                            height: 200,
                            width: width(context) * 0.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(posts[index].image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        Text(posts[index].content,
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        IconButton(
                            onPressed: () async {
                              await getComments(posts[index].id!);
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                      top: height(context) * 0.1),
                                  child: commentTextField(
                                    context,
                                    posts[index].id!,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.chat)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Future<List<UserModel>> getMembers({required List<String>members, required String type})  async{
    List<UserModel> users = [UserModel(name: '', email: '', uid: '', photoUrl: '', isTeacher: true)];
    for (String element in members) {
  await    FirebaseFirestore.instance.collection(type).doc(element).get().then((value) {
        UserModel user = UserModel.fromMap(value.data()!);
        log("user name ${user.name}");
        users.add(user);
        log("user name ${(users).last.name}");
        log("users length ${(users).length}");

      });

    }
    return users;


  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = "${dateTime.day}/${dateTime.month}";
    String formattedTime =
        "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
    String period = dateTime.hour < 12 ? 'am' : 'pm';
    if (dateTime.hour > 12) {
      formattedTime =
          "${dateTime.hour - 12}:${dateTime.minute.toString().padLeft(2, '0')}";
    } else if (dateTime.hour == 0) {
      formattedTime = "12:${dateTime.minute.toString().padLeft(2, '0')}";
    }
    return "$formattedDate $formattedTime $period";
  }

  Widget commentTextField(context, String postId) {
    log("comments $comments");

    /*
    TODO:
    when user commented on the post, it should be added to the comment list
     */

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: comments.length > 0
              ? ListView.separated(
                  itemCount: comments.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    print(comments[index].userId);
                    UserModel? commentedUser =
                        getUserInfo(comments[index].userId);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: commentedUser!.photoUrl != null
                            ? NetworkImage(commentedUser.photoUrl!)
                            : AssetImage(profileAsset) as ImageProvider,
                      ),
                      title: Text(commentedUser.name),
                      subtitle: Text(comments[index].comment),
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: Text("No Comments yet"),
                  ),
                ),
        ),
        Row(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: width(context) * 0.06),
                    hintText: "Write Comment...",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: firstColor, width: 1),
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(height(context) * 0.09),
                          left: Radius.circular(height(context) * 0.09)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: firstColor, width: 1),
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(height(context) * 0.07),
                          left: Radius.circular(height(context) * 0.07)),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                addCommentToPost(postId);
                messageController.clear();
                setState(() {});
              },
              icon: Container(
                width: height(context) * 0.07,
                height: height(context) * 0.07,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  UserModel? getUserInfo(String id) {
    for (var teacher in teachers) {
      if (teacher.uid == id) {
        return teacher;
      }
    }

    print("Teacher not found, checking if student...");

    for (var student in students) {
      if (student.uid == id) {
        return student;
      }
    }

    return null;
  }

  fetchData() async {
    getAllPosts();
    getAllQuizzes();
    await getTeachers(widget.group.teachers!);
    await getStudents(widget.group.students!);
  }

  getComments(String postId) async {
    comments.clear();
    log("get comments");
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(postsCollection)
        .doc(postId)
        .collection(commentsCollection)
        .get()
        .then((value) {
      log("comments length ${value.docs.length}");
      for (var element in value.docs) {
        log("adding comment ${element.data()}");
        setState(() {
          comments.add(CommentModel.fromMap(element.data()));
        });
      }
    });
  }

  void addCommentToPost(String postId) async {
    if (formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection(groupsCollection)
          .doc(widget.group.id)
          .collection(postsCollection)
          .doc(postId)
          .collection(commentsCollection)
          .add(CommentModel(
                  comment: messageController.text.trim(),
                  userId: current_user.uid!,
                  isTeacher: current_user.isTeacher)
              .toMap())
          .then((value) {
        setState(() {
          messageController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Your Comment Added Successfully"),
          ),
        );
      });
    }
  }
}
