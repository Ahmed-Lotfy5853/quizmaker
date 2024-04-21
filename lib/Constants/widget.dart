import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/responsive.dart';
import 'package:quiz_maker/Constants/styles.dart';

Widget commentTextField(context) => Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: 20,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(groupAsset),
              ),
              title: Text('Name student'),
              subtitle: Text(" فعلا البوست جميل شكر لك"),
              trailing: Text("TimeDate"),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                //  controller: messageController
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: width(context)*0.06
                  ),
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
            IconButton(
              onPressed: () {},
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
