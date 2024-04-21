import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';

import '../../../Data/Models/group.dart';

class GroupDetailsView extends StatefulWidget {
  GroupDetailsView({super.key});

  @override
  State<GroupDetailsView> createState() => _GroupDetailsViewState();
}

class _GroupDetailsViewState extends State<GroupDetailsView> {
  final Group group = Group(
    id: "123",
    name: "Group 1",
    description: "Group 1 description try to write a long description for this group to see how it will look like",
    teachers: ["Dr. John", "Dr. Smith"],
    createdBy: "Dr. Smith",
    image: 'assets/images/profile_place_holder.png', createdAt: '',
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    //Group? group = ModalRoute.of(context)!.settings.arguments as Group;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          group.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    group.description??'',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, createQuizScreen );
                    },
                    child: Container(
                      height: height / 12,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Text(
                                "Create Quiz !",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: smallerTextFontsize,
                                ),
                              ),
                              Icon(Icons.list_alt_sharp)
                            ],
                          )),
                    ),
                  ),
                ),SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context,  questionsBankScreen );
                    },
                    child: Container(
                      height: height / 12,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Text(
                                "Questions Bank",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: smallerTextFontsize,
                                ),
                              ),
                              Icon(Icons.account_balance_sharp)
                            ],
                          )),
                    ),
                  ),
                ),SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context,  addTeachertoGroup );
                    },
                    child: Container(
                      height: height / 12,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Text(
                                "Add a Teacher",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: smallerTextFontsize,
                                ),
                              ),
                              Icon(Icons.person_add_sharp)
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
