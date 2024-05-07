import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Data/Models/requests.dart';
import '../../../../Constants/responsive.dart';
import '../../../../Data/Models/group.dart';
import '../Groups/teacher_group_details.dart';

class TeacherHomeScreen extends StatefulWidget {
  TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  //for test
  List<Group> allGroupsList = [];

  List<Group> _searchresult = [];

  List<Group> userGroupsList = [];

  TextEditingController _searchController = TextEditingController();
  bool isSearch = false;

  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  List<String> groups_ids = [];
  List<Group> allGroups = [];
  List<Group> userGroups = [];

  Future<void> createGroup(Group group, File? image) async {
    DocumentReference documentReference =
        await firestore.collection(teachersCollection).doc(current_user.uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    List<String> currentArray = List.from(documentSnapshot.get('groups') ?? []);
    await firestore
        .collection(groupsCollection)
        .add(group.toMap())
        .then((value) {
      currentArray.add(value.id);
      value.update({"id": value.id});
      documentReference.update({"groups": currentArray});
    });
  }

  Future<String?> uploadGroupPhoto(File? imageFile, String imageName) async {
    if (imageFile == null) {
      return null;
    }
    String reference = "groups";
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
    return null;
  }

  Future<List<Group>> getAllGroups() async {
    try {
      await firestore.collection(groupsCollection).get().then((value) {
        value.docs.forEach((element) {
          print(element["students"]);
          allGroups.add(Group.fromMap(element.data()));
        });
      });
      print("all groups length ${allGroups.length}");
      /*   allGroups.forEach((element) {
        print(element.id);
      });*/

      return allGroups;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Group>> getUserAllGroups() async {
    log("user groups IDs ${current_user!.groups}");
    setState(() {
      userGroupsList = allGroups.where((element) {
        log("element ${element.id}");
        log("is joined ${(current_user!.groups ?? []).contains(element.id)}");
        return (current_user!.groups ?? []).contains(element.id);
      }).toList();
    });
    return userGroupsList;
  }

  @override
  void initState() {
    super.initState();
    fetchAllGroups();
  }

  @override
  void didUpdateWidget(covariant TeacherHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var smallFontsize = MediaQuery.textScalerOf(context).scale(15);

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: nextColor),
            controller: _searchController,
            onChanged: (value) {
              print(value);
              setState(() {
                isSearch = value.isNotEmpty;

                _searchresult = _searchMethed(value.toLowerCase());
                //check user is searching or no
                print("isSearching: $isSearch");
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: firstColor,
              prefixIcon: Icon(
                Icons.search,
                color: nextColor,
              ),
              labelStyle: TextStyle(color: nextColor),
              hintText: 'Search About Groups ...',
              hintStyle: TextStyle(color: nextColor),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 0.0)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? userGroupsList.isEmpty
                    ? _noData('There are no Groups', smallFontsize)
                    : _buildGroup(userGroupsList, width)
                : _searchresult.isNotEmpty
                    ? _buildSearchResults(_searchresult, width)
                    : _noData('There are no Results', smallFontsize),
          ),
        ],
      ),
    );
  }

  // if there no Groups
  Widget _noData(String message, double? fsize) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: fsize, color: Colors.black),
      ),
    );
  }

// fuction for seaching
  List<Group> _searchMethed(String name) {
    List<Group> results = [];
    allGroupsList.forEach((element) {
      print(element.name);
      if (element.name.toLowerCase().contains(name)) {
        print(name);
        print(element);
        results.add(element);
      }
    });
    return results;
  }

  // build groups is joined
  Widget _buildGroup(List<Group> dataGroup, double width) {
    return ListView.builder(
      itemBuilder: (_, int index) {
        print(dataGroup.length);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => TeacherGroupDetails(
                        group: dataGroup[index],
                      )),
            );
          },
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: width * 0.07,
                backgroundImage: dataGroup[index].image != null
                    ? NetworkImage(dataGroup[index].image!)
                    : AssetImage(profileAsset) as ImageProvider,
              ),
              title: Text(
                dataGroup[index].name,
                style: GroupOrNameTextStyle(context),
              ),
              subtitle: Text(
                dataGroup[index].description,
                maxLines: 1,
              ),
            ),
          ),
        );
      },
      itemCount: userGroupsList.length,
    );
  }

  // ui for Search results
  Widget _buildSearchResults(List<Group> dataGroup, double width) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final Group group = dataGroup[index];
          final bool isInGroup = userGroupsList.contains(dataGroup[index]);

          return InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: width / 12,
                      backgroundImage: group.image != null
                          ? NetworkImage(group.image!)
                          : AssetImage(profileAsset) as ImageProvider,
                    ),
                    Text(
                      group.name,
                      overflow: TextOverflow.ellipsis,
                      style: GroupOrNameTextStyle(context),
                    ),
                    Text(
                      group.description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: fSize(context, 15.0),
                      ),
                    ),
                    if (!isInGroup) // Add the tile conditionally based on isInGroup
                      InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection(teachersCollection)
                              .doc(group.teachers?[0])
                              .collection(current_user.isTeacher
                                  ? teacherRequestsCollection
                                  : studentRequestsCollection)
                              .add(Request(
                                name: current_user.name,
                                userId: current_user.uid,
                                groupId: dataGroup[index].id!,
                                isPending: true,
                                id: '',
                              ).toMap())
                              .then((value) {
                            value.update({"id": value.id});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Request Sent Successfully'),
                              ),
                            );

                            setState(() {
                              _searchController.clear();
                            });
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Join',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: dataGroup.length,
      ),
    );
  }

  Future<void> fetchAllGroups() async {
    List<Group> h = await getAllGroups();

    await getUserAllGroups();
    // userGroupsList = g;
    log("user groups ${userGroupsList.length}");
    allGroupsList = h;

    // print("ggg" + g.toString());
  }

  getUserGroups() async {
    log('user groups ${groups_ids.length}');
    setState(() {
      for (var groupId in groups_ids) {
        firestore.collection(groupsCollection).doc(groupId).get().then((value) {
          log("user group  ${value.data()}");
          if (value.data() != null) {
            userGroups.add(Group.fromMap(value.data()!));
            ;
          }
        });
      }
    });
    log("user groups ${userGroups.length}");
  }
}
