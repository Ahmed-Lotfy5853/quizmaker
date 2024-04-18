import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Data/Models/group.dart';
import 'package:quiz_maker/Data/Models/teacher.dart';

class AddTeacherToGroup extends StatefulWidget {
  const AddTeacherToGroup({super.key});

  @override
  State<AddTeacherToGroup> createState() => _AddTeacherToGroupState();
}

class _AddTeacherToGroupState extends State<AddTeacherToGroup> {
  List<Teacher> allTeachers = [
    Teacher("1", "Dr. Smith", "assets/images/profile_place_holder.png"),
    Teacher("2", "Dr. John", "assets/images/profile_place_holder.png"),
    Teacher("3", "Dr. Doe", "assets/images/profile_place_holder.png"),
  ];
  List<Teacher> searchedTeachers = [];
  bool isSearch = false;
  final searchTextController = TextEditingController();

  Widget buildSearchfield() {
    return TextField(
      autofocus: true,
      controller: searchTextController,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Find a teacher...",
        border: InputBorder.none,
        hintStyle:
        TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 20),
      ),
      onChanged: (searchedChar) {
        createSearchedList(searchedChar);
      },
    );
  }

  void createSearchedList(String searchedChar) {
    searchedTeachers = allTeachers
        .where((element) => element.name.toLowerCase().contains(searchedChar))
        .toList();
    setState(() {});
  }

  List<Widget> buildSearchAppbarItems() {
    if (isSearch) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startseach();
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ];
    }
  }

  void startseach() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearch = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearch = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  Widget buildAppbarTitle() {
    return const Text(
      "Find a teacher",
      style: TextStyle(color: Colors.white),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(25);

    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 243, 1),
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: isSearch
              ? const BackButton(
            color: Colors.white,
          )
              : SizedBox(),
          title: isSearch ? buildSearchfield() : buildAppbarTitle(),
          actions: buildSearchAppbarItems(),
        ),
        body: ListView.builder(
            itemCount: isSearch ? searchedTeachers.length : allTeachers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: () {
                      showMessageDialog(
                          height, width, smallerTextFontsize, bigTextFontsize,
                          isSearch ? searchedTeachers[index].name : allTeachers[index].name);
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          isSearch
                              ? searchedTeachers[index].img
                              : allTeachers[index].img
                      ),

                    ),
                    title: Text(
                      isSearch
                          ? searchedTeachers[index].name
                          : allTeachers[index].name,
                    )
                ),

              );
            }
        )
    );
  }

  void showMessageDialog(double h, double w, double fontSize, double bigfont,
      String name) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Add $name to this Group ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: bigfont,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          //ToDo add teacher to group logic
                        },
                        child: Container(
                          height: h / 13.75,
                          width: w / 4,
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                                "yes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w / 13,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: h / 13.75,
                          width: w / 4,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                                "No",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
