import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/responsive.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/GroupDetails/group_details.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for test
  List<ModelGroup> _list = [
    ModelGroup(
        nameGroup: 'Mohamed Youssef',
        image: profileAsset,
        lastMessage: 'Flutter Developer'),
    ModelGroup(
        nameGroup: 'Ahmed Ali', image: profileAsset, lastMessage: 'Maths'),
    ModelGroup(
        nameGroup: 'eman mostafa',
        image: profileAsset,
        lastMessage: 'English Teacher'),
    ModelGroup(nameGroup: 'omar Ali', image: profileAsset, lastMessage: 'Ai'),
  ];
  List<ModelGroup> _data = [
    ModelGroup(
        nameGroup: 'Flutter Group',
        image: profileAsset,
        lastMessage: 'I don`t get it,can you explain to me again ..?'),
    ModelGroup(
        nameGroup: ' الذكاء الإصنطناعى',
        image: profileAsset,
        lastMessage: 'لا مش واضحه'),
    ModelGroup(
        nameGroup: 'Machine Learning Group',
        image: profileAsset,
        lastMessage: 'I can`t'),
    ModelGroup(
        nameGroup: 'الرياضيات',
        image: profileAsset,
        lastMessage: 'ممكن تعيد شرح النقطة دى تانى'),
    ModelGroup(
        nameGroup: 'Data Science Group',
        image: profileAsset,
        lastMessage: 'i`ts ok '),
  ];
  List<ModelGroup> _searchresult = [];

  TextEditingController _searchController = TextEditingController();
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: nextColor),
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchresult = _searchMethed(value.toLowerCase());
                  //check user is searching or no
                  value.length == 0 ? isSearch = false : isSearch = true;
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
              child: !isSearch
                  ? _data.length != 0
                      ? _buildGroup(_data)
                      : _noData('There no Groups')
                  : _searchresult.length != 0
                      ? _buildSearchResults(_searchresult)
                      : _noData('There no Result'),
            ),
          ],
        ),
      ),
    );
  }

  // if there no Groups
  Widget _noData(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: fSize(context, 25), color: nextColor),
      ),
    );
  }

// fuction for seaching
  List<ModelGroup> _searchMethed(String name) {
    List<ModelGroup> results = [];
    _list.forEach((element) {
      if (element.nameGroup.toLowerCase().contains(name)) {
        results.add(element);
      }
    });
    return results;
  }

  // build groups is joined
  Widget _buildGroup(List<ModelGroup> dataGroup) {
    return ListView.builder(
      itemBuilder: (_, int index) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, studentGroupDetailScreen);
        
            },
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: width(context) * 0.07,
              backgroundImage: AssetImage(dataGroup[index].image),
            ),
            title: Text(
              dataGroup[index].nameGroup,
              style: GroupOrNameTextStyle(context),
            ),
            subtitle: Text(
              dataGroup[index].lastMessage,
              maxLines: 1,
            ),
          ),
        ),
      ),
      itemCount: _data.length,
    );
  }

  // ui for Search results
  Widget _buildSearchResults(List<ModelGroup> dataGroup) {
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
        childCount: dataGroup.length,
        (context, index) => InkWell(
          onTap: () {},
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: width(context) * 0.14,
                  backgroundImage: AssetImage(dataGroup[index].image),
                ),
                Text(
                  dataGroup[index].nameGroup,
                  style: GroupOrNameTextStyle(context),
                ),
                Text(
                  dataGroup[index].lastMessage,
                  style: TextStyle(
                    fontSize: fSize(context, 15.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ModelGroup {
  String nameGroup, image, lastMessage;
  ModelGroup({
    required this.nameGroup,
    required this.image,
    required this.lastMessage,
  });
}