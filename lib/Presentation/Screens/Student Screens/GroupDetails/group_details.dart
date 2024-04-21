import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/responsive.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Constants/widget.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/GroupDetails/Quize/quize.dart';

class StudentGroupDetails extends StatefulWidget {
  StudentGroupDetails({
    super.key,
  });

  @override
  State<StudentGroupDetails> createState() => _StudentGroupDetailsState();
}

class _StudentGroupDetailsState extends State<StudentGroupDetails> {
  // String groupName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Group'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // for quiz
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, int index) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(quizeScreen);
                },
                child: Card(
                  child: Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: false,
                        onChanged: (bool? value) {},
                      ),
                      title: Text('"Name Quize"'),
                      trailing: Text("From   to    "),
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
              itemCount: 10,
              itemBuilder: (context, int index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(groupAsset),
                    ),
                    title: Text('Name Teacher'),
                    trailing: Text("From   to    "),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width(context) * 0.07),
                    child: Text(
                        "Checkbox in flutter is a material design widget. It is always used in the Stateful Widget as it does not maintain a state of its own. We can use its onChanged property to interact or modify other widgets in the flutter app. Like most of the other flutter widgets, it also comes with many properties like activeColor, checkColor, mouseCursor, etc, to let developers have full control over the widget’s look and feel."),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width(context) * 0.07),
                    child: Row(
                      children: [
                        Text('10 like'),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.favorite)),
                        Text('10 comment'),
                        IconButton(
                            onPressed: () {
                              // for comment
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                      top: height(context) * 0.1),
                                  child: commentTextField(context),
                                ),
                              );
                            },
                            icon: Icon(Icons.chat)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
