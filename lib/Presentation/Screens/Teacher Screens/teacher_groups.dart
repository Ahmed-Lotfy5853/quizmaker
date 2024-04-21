import 'package:flutter/material.dart';

import '../../../Constants/Strings.dart';
import '../../../Data/Models/group.dart';


class TeacherGroups extends StatefulWidget {
  const TeacherGroups({super.key});

  @override
  State<TeacherGroups> createState() => _TeacherGroupsState();
}

class _TeacherGroupsState extends State<TeacherGroups> {
  List<Group> groups = [
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 2",
      description: "Group 2 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 3",
      description: "Group 3 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),

    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
    Group(
      id: "123",
      name: "Group 1",
      description: "Group 1 description",
      teachers: ["Dr. John", "Dr. Smith"],
      createdBy: "Dr. Smith",
      image: 'assets/images/profile_place_holder.png', createdAt: '',
    ),
  ];
  bool isSearching = false;
  List<Group> searchedGroups = [];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(15);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(20);
    return  Container(
      child: Column(
        children: [
          Container(
            height: h / 3.75 ,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: h/ 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: h /20,
                      child: ClipOval(
                        // Todo add profile picture logic
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/profile_place_holder.png',
                          // Placeholder image
                          image: 'https://example.com/profile_picture.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          // Adjust width and height as per your requirement
                          height: 100,
                          imageErrorBuilder: (context, error, stackTrace) {
                            // Handle network image loading failures here
                            return Image.asset(
                              'assets/images/profile_place_holder.png',
                              // Placeholder image
                              fit: BoxFit.cover,
                              width: 100,
                              // Adjust width and height as per your requirement
                              height: 100,
                            );
                          },
                        ),
                      ),
                    ),
                    //Todo add name logic
                    Container(
                      width: w / 2.61,
                      child: Text(
                        "Dr. Mohamed Ahmed Omar Khalil Ibrahim",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: bigTextFontsize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, createGroupScreen);
                            },
                            icon: Icon(
                              Icons.add_circle_outlined,
                              color: Colors.green,
                              size: h / 20,
                            )),
                        Text(
                          "Create group",
                          style: TextStyle(color: Colors.green , fontSize: smallerTextFontsize),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: h / 82.5),
                Padding(
                  padding:  EdgeInsets.only(left: w / 26, right: w / 26),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 243, 243, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        hintText: "Search for specific teacher/group",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: smallerTextFontsize,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: smallerTextFontsize,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          isSearching = true;
                          searchedGroups = groups.where((element) {
                            return element.name
                                .toLowerCase()
                                .contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: w / 39.2),
                  child: Text(
                    "My Groups",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: bigTextFontsize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: h / 1.65,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    itemCount:
                    isSearching ? searchedGroups.length : groups.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: h/ 27.5,
                          backgroundImage: Image.asset(isSearching
                              ? searchedGroups[index].image!
                              : groups[index].image!)
                              .image,
                        ),
                        title: Text(
                          isSearching
                              ? searchedGroups[index].name
                              : groups[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold , fontSize: bigTextFontsize),
                        ),
                        subtitle: Text(isSearching
                            ? searchedGroups[index].description!
                            : groups[index].description! , style: TextStyle(fontSize: smallerTextFontsize),),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.white,
                        thickness: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
